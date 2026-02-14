# Quiz App - iOS SwiftUI

A production-ready iOS quiz application built with Swift and SwiftUI following MVVM architecture.

## Features

### Core Functionality
- **Infinite Practice Mode**: Questions shuffle at the start of each session and loop continuously
- **Smart Feedback**: Instant visual feedback (green for correct, red for incorrect)
- **Auto-Advance**: Automatically moves to the next question after 1.3 seconds
- **Comprehensive Scoring**: Tracks correct answers, attempts, and current streak
- **Persistent Data**: Scores and settings persist across app launches using UserDefaults

### User Interface
- Clean, minimal design ready for App Store
- Progress indicator showing current question position
- Score display with correct/attempted ratio and streak counter
- Settings panel with customization options
- Restart Round and Reset Score buttons

### Settings
- **Keep Score When Looping**: Toggle to maintain or reset score when cycling through questions (default: keep score)

## Project Structure

```
QuizApp/
├── QuizApp/
│   ├── Models/
│   │   └── Question.swift              # Question model with validation
│   ├── ViewModels/
│   │   └── QuizViewModel.swift         # Business logic and state management
│   ├── Views/
│   │   ├── ContentView.swift           # Main quiz interface
│   │   └── Components/
│   │       ├── OptionButton.swift      # Reusable answer button
│   │       ├── ScoreView.swift         # Score display component
│   │       └── QuizProgressView.swift  # Progress bar component
│   └── QuizAppApp.swift                # App entry point
└── README.md
```

## Architecture

### MVVM Pattern
- **Model** ([Question.swift](QuizApp/Models/Question.swift)): Data structure for quiz questions with built-in validation
- **ViewModel** ([QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift)): Business logic, state management, and persistence
- **View** ([ContentView.swift](QuizApp/Views/ContentView.swift)): UI components and user interaction

### Key Components

#### Question Model
- Validates options count (3-5 options)
- Validates correct index is within bounds
- Includes 10 sample questions with varied option counts
- Designed for easy migration to JSON loading

#### QuizViewModel
- Manages question shuffling and navigation
- Tracks scoring (correct, attempted, streak)
- Handles answer selection and auto-advance
- Persists data using `@AppStorage` (UserDefaults)
- Provides computed properties for UI binding

#### UI Components
- **OptionButton**: Reusable button with dynamic styling
- **ScoreView**: Displays score and streak information
- **QuizProgressView**: Animated progress bar
- **ContentView**: Main quiz interface with settings

## Setup Instructions

### Using Xcode (Recommended)

1. **Open Xcode** (download from Mac App Store if needed)

2. **Create a new iOS App project**:
   - File → New → Project
   - Select "iOS" → "App"
   - Click "Next"
   - Product Name: `QuizApp`
   - Organization Identifier: `com.yourname` (or your preference)
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: **None**
   - Click "Next" and choose a save location

3. **Replace the generated files** with the files from this project:
   - Delete the default `ContentView.swift` and `QuizAppApp.swift`
   - Create folders: Right-click on QuizApp → New Group
     - Create `Models`, `ViewModels`, `Views`, `Views/Components`
   - Add files: Right-click on each folder → Add Files to "QuizApp"
     - Add corresponding `.swift` files from this project
   - Or simply copy all files into the Xcode project navigator

4. **Run the app**:
   - Select a simulator (e.g., iPhone 15 Pro)
   - Click the "Play" button or press `Cmd + R`

### Using VS Code with Swift

If you prefer to work in VS Code:

1. Install the [Swift extension for VS Code](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang)

2. You'll still need Xcode installed for iOS simulators and SDKs

3. Build using command line:
   ```bash
   cd QuizApp
   xcodebuild -scheme QuizApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
   ```

## Adding New Questions

Questions are currently defined in [Question.swift](QuizApp/Models/Question.swift) in the `sampleQuestions` array.

### Add a New Question

```swift
Question(
    text: "Your question text here?",
    options: [
        "Option A",
        "Option B",
        "Option C",
        "Option D"  // Optional: 3-5 options supported
    ],
    correctIndex: 0  // Index of correct answer (0-based)
)
```

### Question Validation
The app automatically validates:
- Options count must be 3-5
- Correct index must be within options bounds
- Invalid questions will trigger a runtime error with a helpful message

### Future: JSON Loading
The architecture supports easy migration to JSON:

1. Create a `questions.json` file:
```json
[
  {
    "text": "Your question?",
    "options": ["A", "B", "C"],
    "correctIndex": 0
  }
]
```

2. Load in [QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift):
```swift
// Replace Question.sampleQuestions with:
loadQuestionsFromJSON()
```

## Customization

### Timing
Adjust auto-advance delay in [QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift#L119):
```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { // Change 1.3 to desired seconds
```

### Colors
Modify colors in [QuizViewModel.swift](QuizApp/ViewModels/QuizViewModel.swift#L162-L195):
- Correct answer: `.green.opacity(0.3)`
- Wrong answer: `.red.opacity(0.3)`

### UI Styling
Adjust fonts, spacing, and corner radius in component files:
- [OptionButton.swift](QuizApp/Views/Components/OptionButton.swift)
- [ScoreView.swift](QuizApp/Views/Components/ScoreView.swift)
- [QuizProgressView.swift](QuizApp/Views/Components/QuizProgressView.swift)

## Requirements

- iOS 15.0 or later
- Xcode 14.0 or later
- Swift 5.7 or later
- No external dependencies

## Technical Highlights

### Defensive Programming
- Input validation with descriptive error messages
- Guard statements to prevent invalid states
- Bounds checking for array access
- Type-safe option handling

### Performance
- Efficient shuffling using Swift's native `.shuffled()`
- Minimal view updates with `@Published` properties
- Lightweight persistence with UserDefaults

### Best Practices
- MVVM separation of concerns
- Reusable components
- SwiftUI declarative syntax
- Comprehensive comments
- Preview providers for components

## License

This project is provided as-is for educational and commercial use.

## Support

For questions or issues:
1. Check the inline code comments
2. Review the MVVM architecture documentation
3. Verify question validation requirements
