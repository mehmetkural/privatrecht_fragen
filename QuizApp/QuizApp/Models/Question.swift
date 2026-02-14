//
//  Question.swift
//  QuizApp
//
//  Model representing a quiz question with validation
//

import Foundation

/// Model representing a single quiz question
struct Question: Identifiable, Equatable {
    let id: UUID
    let text: String
    let options: [String]
    let correctIndex: Int

    /// Initialize a new question with validation
    /// - Parameters:
    ///   - text: The question text
    ///   - options: Array of answer options (must have 3-5 items)
    ///   - correctIndex: Index of the correct answer (must be within options bounds)
    init(text: String, options: [String], correctIndex: Int) {
        // Validate options count
        guard options.count >= 3 && options.count <= 5 else {
            fatalError("Question must have between 3 and 5 options. Got \(options.count) for question: '\(text)'")
        }

        // Validate correctIndex is within bounds
        guard correctIndex >= 0 && correctIndex < options.count else {
            fatalError("correctIndex (\(correctIndex)) must be within options bounds (0..<\(options.count)) for question: '\(text)'")
        }

        self.id = UUID()
        self.text = text
        self.options = options
        self.correctIndex = correctIndex
    }

    /// Check if a given index is the correct answer
    /// - Parameter index: The index to check
    /// - Returns: True if the index matches the correct answer
    func isCorrectAnswer(_ index: Int) -> Bool {
        return index == correctIndex
    }
}

// MARK: - Sample Questions
extension Question {
    /// Sample questions for the quiz app
    /// This array can later be replaced with JSON loading
    static let sampleQuestions: [Question] = [
        // 3-option question
        Question(
            text: "Welche Rechtsquelle steht in der Normenhierarchie an oberster Stelle?",
            options: [
                "Bundesverfassung",
                "Bundesgesetz",
                "Verordnung"
            ],
            correctIndex: 0
        ),

        // 4-option questions
        Question(
            text: "Was versteht man unter dem Legalitätsprinzip?",
            options: [
                "Alle staatlichen Handlungen müssen auf einer gesetzlichen Grundlage beruhen",
                "Gesetze müssen veröffentlicht werden",
                "Jeder ist vor dem Gesetz gleich",
                "Das Gesetz gilt rückwirkend"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Welche Aussage über die Rechtsfähigkeit ist korrekt?",
            options: [
                "Beginnt mit der Geburt",
                "Beginnt mit der Volljährigkeit",
                "Kann durch Gerichtsbeschluss entzogen werden",
                "Ist an die Geschäftsfähigkeit gekoppelt"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Wann ist eine natürliche Person handlungsfähig?",
            options: [
                "Mit 18 Jahren (volljährig und urteilsfähig)",
                "Mit 16 Jahren",
                "Mit der Geburt",
                "Nach bestandener Prüfung"
            ],
            correctIndex: 0
        ),

        // 5-option question
        Question(
            text: "Welche Voraussetzungen müssen für einen gültigen Vertrag erfüllt sein?",
            options: [
                "Übereinstimmende gegenseitige Willensäusserungen",
                "Nur schriftliche Form",
                "Notarielle Beglaubigung",
                "Zeugen müssen anwesend sein",
                "Eintragung ins Handelsregister"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Was bedeutet 'Vertragsfreiheit' im Privatrecht?",
            options: [
                "Freie Wahl des Vertragspartners, Inhalts und der Form",
                "Verträge können jederzeit aufgelöst werden",
                "Nur mündliche Verträge sind gültig",
                "Der Staat bestimmt die Vertragsbedingungen",
                "Verträge müssen immer schriftlich sein"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Welcher Grundsatz gilt bei der Vertragsauslegung?",
            options: [
                "Der wirkliche übereinstimmende Wille der Parteien ist massgebend",
                "Immer der Wortlaut",
                "Die strengste Auslegung",
                "Die günstigste für den Verkäufer",
                "Die vom Richter bevorzugte Variante"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Was ist ein Willensmangel?",
            options: [
                "Irrtum, Täuschung oder Furcht bei Vertragsabschluss",
                "Fehlende Unterschrift",
                "Zu hoher Preis",
                "Fehlende Zeugen",
                "Mündliche statt schriftliche Form"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Welche Form ist für einen Grundstückkaufvertrag erforderlich?",
            options: [
                "Öffentliche Beurkundung",
                "Einfache Schriftlichkeit",
                "Mündliche Vereinbarung genügt",
                "E-Mail ist ausreichend",
                "Keine besondere Form nötig"
            ],
            correctIndex: 0
        ),

        Question(
            text: "Was versteht man unter 'Stellvertretung'?",
            options: [
                "Handeln im Namen und auf Rechnung eines anderen",
                "Gemeinsame Vertragsunterzeichnung",
                "Zeuge beim Vertragsabschluss",
                "Nachträgliche Genehmigung",
                "Informelle Empfehlung"
            ],
            correctIndex: 0
        )
    ]
}
