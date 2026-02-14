//
//  OptionButton.swift
//  QuizApp
//
//  Reusable button component for quiz answer options
//

import SwiftUI

/// A reusable button component for displaying quiz answer options
struct OptionButton: View {
    let text: String
    let backgroundColor: Color
    let borderColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 12) {
        OptionButton(
            text: "Default option",
            backgroundColor: Color(.systemGray6),
            borderColor: Color(.systemGray4),
            action: {}
        )

        OptionButton(
            text: "Correct answer",
            backgroundColor: .green.opacity(0.3),
            borderColor: .green,
            action: {}
        )

        OptionButton(
            text: "Wrong answer",
            backgroundColor: .red.opacity(0.3),
            borderColor: .red,
            action: {}
        )
    }
    .padding()
}
