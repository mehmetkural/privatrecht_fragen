//
//  QuizViewModel.swift
//  QuizApp
//
//  ViewModel managing quiz logic, scoring, and state
//

import Foundation
import SwiftUI

/// ViewModel handling all quiz business logic
class QuizViewModel: ObservableObject {
    // MARK: - Published Properties

    /// All questions in their current shuffled order
    @Published private(set) var questions: [Question] = []

    /// Index of the current question being displayed
    @Published private(set) var currentQuestionIndex: Int = 0

    /// The index of the option selected by the user (nil if not answered yet)
    @Published private(set) var selectedOptionIndex: Int?

    /// Whether the current question has been answered (locks further taps)
    @Published private(set) var isAnswered: Bool = false

    /// Number of questions answered correctly
    @Published private(set) var correctCount: Int = 0

    /// Total number of questions attempted
    @Published private(set) var attemptedCount: Int = 0

    /// Current streak of consecutive correct answers
    @Published private(set) var currentStreak: Int = 0

    // MARK: - Settings (Persisted)

    /// Whether to keep the score when looping back to start (UserDefaults)
    @AppStorage("keepScoreOnLoop") var keepScoreOnLoop: Bool = true

    /// Persisted correct count
    @AppStorage("persistedCorrectCount") private var persistedCorrectCount: Int = 0

    /// Persisted attempted count
    @AppStorage("persistedAttemptedCount") private var persistedAttemptedCount: Int = 0

    /// Persisted streak
    @AppStorage("persistedStreak") private var persistedStreak: Int = 0

    // MARK: - Computed Properties

    /// The current question being displayed
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    /// Total number of questions in the current round
    var totalQuestions: Int {
        return questions.count
    }

    /// Progress text (e.g., "Question 5 of 10")
    var progressText: String {
        return "Question \(currentQuestionIndex + 1) of \(totalQuestions)"
    }

    /// Score text (e.g., "15 / 20")
    var scoreText: String {
        return "\(correctCount) / \(attemptedCount)"
    }

    /// Streak text (e.g., "Streak: 5")
    var streakText: String {
        return "Streak: \(currentStreak)"
    }

    // MARK: - Initialization

    init() {
        // Load persisted scores
        loadPersistedScores()

        // Initialize with shuffled questions
        startNewRound()
    }

    // MARK: - Core Quiz Logic

    /// Start a new round: shuffle questions and optionally reset score
    func startNewRound(resetScore: Bool = false) {
        // Shuffle questions from the sample data
        questions = Question.sampleQuestions.shuffled()

        // Reset question state
        currentQuestionIndex = 0
        selectedOptionIndex = nil
        isAnswered = false

        // Reset score if requested
        if resetScore {
            resetScores()
        }
    }

    /// Handle user selecting an option
    /// - Parameter index: The index of the selected option
    func selectOption(_ index: Int) {
        // Guard: prevent selection if already answered
        guard !isAnswered else { return }

        // Guard: validate index is within bounds
        guard let question = currentQuestion,
              index >= 0 && index < question.options.count else {
            return
        }

        // Lock the question from further taps
        isAnswered = true
        selectedOptionIndex = index

        // Update scoring
        attemptedCount += 1

        if question.isCorrectAnswer(index) {
            correctCount += 1
            currentStreak += 1
        } else {
            currentStreak = 0 // Reset streak on wrong answer
        }

        // Persist scores
        saveScores()

        // Auto-advance after 1.2-1.5 seconds (using 1.3s as middle ground)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { [weak self] in
            self?.moveToNextQuestion()
        }
    }

    /// Move to the next question or loop back
    private func moveToNextQuestion() {
        // Reset answer state
        selectedOptionIndex = nil
        isAnswered = false

        // Move to next question
        currentQuestionIndex += 1

        // Check if we've reached the end of the round
        if currentQuestionIndex >= questions.count {
            // Loop back: reshuffle and continue
            loopBackToStart()
        }
    }

    /// Loop back to start: reshuffle questions and optionally reset score
    private func loopBackToStart() {
        // Reshuffle questions
        questions = Question.sampleQuestions.shuffled()
        currentQuestionIndex = 0

        // Reset score based on user preference
        if !keepScoreOnLoop {
            resetScores()
        }
    }

    /// Manually restart the round (triggered by user button)
    func restartRound() {
        startNewRound(resetScore: false)
    }

    /// Reset all scores to zero
    func resetScores() {
        correctCount = 0
        attemptedCount = 0
        currentStreak = 0
        saveScores()
    }

    // MARK: - Persistence

    /// Save scores to UserDefaults
    private func saveScores() {
        persistedCorrectCount = correctCount
        persistedAttemptedCount = attemptedCount
        persistedStreak = currentStreak
    }

    /// Load scores from UserDefaults
    private func loadPersistedScores() {
        correctCount = persistedCorrectCount
        attemptedCount = persistedAttemptedCount
        currentStreak = persistedStreak
    }

    // MARK: - Helper Methods for UI

    /// Get the background color for an option button
    /// - Parameters:
    ///   - index: The index of the option
    ///   - correctIndex: The index of the correct answer
    /// - Returns: The appropriate color based on state
    func optionBackgroundColor(for index: Int, correctIndex: Int) -> Color {
        // If not answered yet, return default color
        guard isAnswered else {
            return Color(.systemGray6)
        }

        // Highlight correct answer in green
        if index == correctIndex {
            return .green.opacity(0.3)
        }

        // Highlight selected wrong answer in red
        if index == selectedOptionIndex && index != correctIndex {
            return .red.opacity(0.3)
        }

        // Default color for other options
        return Color(.systemGray6)
    }

    /// Get the border color for an option button
    /// - Parameters:
    ///   - index: The index of the option
    ///   - correctIndex: The index of the correct answer
    /// - Returns: The appropriate border color based on state
    func optionBorderColor(for index: Int, correctIndex: Int) -> Color {
        // If not answered yet, return default color
        guard isAnswered else {
            return Color(.systemGray4)
        }

        // Highlight correct answer in green
        if index == correctIndex {
            return .green
        }

        // Highlight selected wrong answer in red
        if index == selectedOptionIndex && index != correctIndex {
            return .red
        }

        // Default color for other options
        return Color(.systemGray4)
    }
}
