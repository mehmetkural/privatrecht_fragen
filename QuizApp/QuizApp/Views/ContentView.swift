//
//  ContentView.swift
//  QuizApp
//
//  Main view displaying the quiz interface
//

import SwiftUI

/// Main view for the quiz application
struct ContentView: View {
    /// ViewModel managing quiz state and logic
    @StateObject private var viewModel = QuizViewModel()

    /// Control sheet presentation for settings
    @State private var showingSettings = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Score display
                    ScoreView(
                        scoreText: viewModel.scoreText,
                        streakText: viewModel.streakText
                    )

                    // Progress indicator
                    QuizProgressView(
                        progressText: viewModel.progressText,
                        currentIndex: viewModel.currentQuestionIndex,
                        totalQuestions: viewModel.totalQuestions
                    )

                    // Question and options
                    if let question = viewModel.currentQuestion {
                        questionView(question: question)
                    } else {
                        // Fallback if no question available
                        Text("No questions available")
                            .foregroundColor(.secondary)
                            .padding()
                    }

                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationTitle("Quiz App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button(action: {
                            viewModel.restartRound()
                        }) {
                            Label("Restart Round", systemImage: "arrow.clockwise")
                        }

                        Button(role: .destructive, action: {
                            viewModel.resetScores()
                        }) {
                            Label("Reset Score", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(viewModel: viewModel)
            }
        }
    }

    /// View for displaying a single question with options
    /// - Parameter question: The question to display
    /// - Returns: A view containing the question text and option buttons
    @ViewBuilder
    private func questionView(question: Question) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            // Question text
            Text(question.text)
                .font(.title3)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 8)

            // Answer options
            VStack(spacing: 12) {
                ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                    OptionButton(
                        text: option,
                        backgroundColor: viewModel.optionBackgroundColor(
                            for: index,
                            correctIndex: question.correctIndex
                        ),
                        borderColor: viewModel.optionBorderColor(
                            for: index,
                            correctIndex: question.correctIndex
                        ),
                        action: {
                            viewModel.selectOption(index)
                        }
                    )
                }
            }
        }
    }
}

/// Settings view for configuring quiz behavior
struct SettingsView: View {
    @ObservedObject var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Keep Score When Looping", isOn: $viewModel.keepScoreOnLoop)
                } header: {
                    Text("Score Settings")
                } footer: {
                    Text("When enabled, your score will continue to accumulate when the quiz loops. When disabled, your score will reset at the start of each new round.")
                }

                Section {
                    HStack {
                        Text("Total Questions")
                        Spacer()
                        Text("\(viewModel.totalQuestions)")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Current Score")
                        Spacer()
                        Text(viewModel.scoreText)
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Current Streak")
                        Spacer()
                        Text("\(viewModel.currentStreak)")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Quiz Info")
                }

                Section {
                    Button("Reset Score", role: .destructive) {
                        viewModel.resetScores()
                        dismiss()
                    }

                    Button("Restart Round") {
                        viewModel.restartRound()
                        dismiss()
                    }
                } header: {
                    Text("Actions")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
