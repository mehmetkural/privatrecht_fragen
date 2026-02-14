//
//  QuizProgressView.swift
//  QuizApp
//
//  Reusable component for displaying quiz progress
//

import SwiftUI

/// A reusable component for displaying quiz progress
struct QuizProgressView: View {
    let progressText: String
    let currentIndex: Int
    let totalQuestions: Int

    /// Calculate progress as a fraction (0.0 to 1.0)
    private var progress: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentIndex + 1) / Double(totalQuestions)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Progress text
            Text(progressText)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)

            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                        .cornerRadius(4)

                    // Progress fill
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * progress, height: 8)
                        .cornerRadius(4)
                        .animation(.easeInOut, value: progress)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        QuizProgressView(progressText: "Question 1 of 10", currentIndex: 0, totalQuestions: 10)
        QuizProgressView(progressText: "Question 5 of 10", currentIndex: 4, totalQuestions: 10)
        QuizProgressView(progressText: "Question 10 of 10", currentIndex: 9, totalQuestions: 10)
    }
    .padding()
}
