# Quick Start Guide

## Getting Started in 3 Steps

### 1. Open in Xcode
```bash
# Open Xcode and create a new iOS App project
# Name: QuizApp
# Interface: SwiftUI
# Language: Swift
```

### 2. Add the Files
Copy these files into your Xcode project:
- `Models/Question.swift`
- `ViewModels/QuizViewModel.swift`
- `Views/ContentView.swift`
- `Views/Components/OptionButton.swift`
- `Views/Components/ScoreView.swift`
- `Views/Components/QuizProgressView.swift`
- `QuizAppApp.swift`

### 3. Run
- Select a simulator (iPhone 15 Pro recommended)
- Press `Cmd + R` to build and run

## File Overview

| File | Purpose | Lines |
|------|---------|-------|
| **Question.swift** | Question data model + 10 sample questions | ~120 |
| **QuizViewModel.swift** | All business logic, scoring, persistence | ~200 |
| **ContentView.swift** | Main quiz UI + settings | ~160 |
| **OptionButton.swift** | Reusable answer button | ~40 |
| **ScoreView.swift** | Score display component | ~40 |
| **QuizProgressView.swift** | Progress bar | ~50 |
| **QuizAppApp.swift** | App entry point | ~15 |

## Key Features Implemented

- ✅ Questions shuffle on each session
- ✅ Infinite loop with automatic reshuffle
- ✅ Instant feedback (green/red highlighting)
- ✅ Auto-advance after 1.3 seconds
- ✅ Score tracking (correct, attempted, streak)
- ✅ Persistent storage (UserDefaults)
- ✅ Settings: Keep/reset score on loop
- ✅ Restart Round button
- ✅ Reset Score button
- ✅ Progress indicator (X of N)
- ✅ Question validation (3-5 options, valid index)
- ✅ MVVM architecture
- ✅ 10 sample questions (including 3-option and 5-option examples)

## Adding Your Own Questions

Edit [Question.swift](QuizApp/Models/Question.swift) around line 50:

```swift
static let sampleQuestions: [Question] = [
    Question(
        text: "Your question text?",
        options: ["A", "B", "C", "D"],  // 3-5 options
        correctIndex: 0  // Index of correct answer
    ),
    // Add more questions here...
]
```

## Common Customizations

### Change Auto-Advance Timing
[QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift) line 119:
```swift
deadline: .now() + 1.3  // Change to 1.5 for slower, 1.0 for faster
```

### Change Colors
[QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift) lines 162-195:
```swift
return .green.opacity(0.3)  // Correct answer color
return .red.opacity(0.3)    // Wrong answer color
```

### Modify Default Setting
[QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift) line 30:
```swift
@AppStorage("keepScoreOnLoop") var keepScoreOnLoop: Bool = true  // Change to false
```

## Testing the App

1. **Basic Flow**:
   - Tap an answer → See feedback → Auto-advance
   - Complete all 10 questions → Automatically reshuffles

2. **Settings**:
   - Tap gear icon → Toggle "Keep Score When Looping"
   - Test both modes (keep vs reset)

3. **Restart & Reset**:
   - Menu (•••) → "Restart Round" (reshuffles, keeps score)
   - Menu (•••) → "Reset Score" (clears all stats)

4. **Validation**:
   - Try adding an invalid question (2 options or 6 options)
   - Try setting correctIndex out of bounds
   - App should crash with descriptive error message

## Next Steps

- Add more questions in [Question.swift](QuizApp/Models/Question.swift)
- Customize colors and fonts
- Test on physical device (requires Apple Developer account)
- Prepare for App Store submission

## Need Help?

- Check the main [README.md](README.md) for detailed documentation
- Review inline code comments in each file
- Verify iOS deployment target in Xcode (iOS 15.0+)
