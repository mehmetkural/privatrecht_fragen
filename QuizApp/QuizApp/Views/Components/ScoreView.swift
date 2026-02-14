//
//  ScoreView.swift
//  QuizApp
//
//  Reusable component for displaying quiz score and streak
//

import SwiftUI

/// A reusable component for displaying score statistics
struct ScoreView: View {
    let scoreText: String
    let streakText: String

    var body: some View {
        HStack(spacing: 20) {
            // Correct / Attempted score
            VStack(alignment: .leading, spacing: 4) {
                Text("Score")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(scoreText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            Divider()
                .frame(height: 40)

            // Streak counter
            VStack(alignment: .leading, spacing: 4) {
                Text("Current Streak")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(streakText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    VStack {
        ScoreView(scoreText: "15 / 20", streakText: "Streak: 5")
        ScoreView(scoreText: "0 / 0", streakText: "Streak: 0")
    }
    .padding()
}
