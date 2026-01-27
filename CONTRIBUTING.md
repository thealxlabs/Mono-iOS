# Contributing to Mono

Thank you for considering contributing to Mono! We welcome contributions from everyone.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Code Contributions](#code-contributions)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Community](#community)

---

## Code of Conduct

This project and everyone participating in it is governed by our commitment to:

- **Be respectful** - Treat everyone with respect and kindness
- **Be collaborative** - Work together and help each other
- **Be constructive** - Provide helpful feedback and criticism
- **Be inclusive** - Welcome diverse perspectives and backgrounds

---

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report, please check existing issues to avoid duplicates.

#### Bug Report Template

When filing a bug report, use this template:
```markdown
## Bug Description
A clear and concise description of what the bug is.

## Device Information
- **Device:** iPhone 15 Pro
- **iOS Version:** 17.2
- **App Version:** 1.0.0

## Steps to Reproduce
1. Go to '...'
2. Tap on '...'
3. Scroll down to '...'
4. See error

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Screenshots
If applicable, add screenshots to help explain your problem.

## Additional Context
Add any other context about the problem here.

## Logs (if applicable)
```
Paste any console logs or error messages here
```
```

**[Create Bug Report](https://github.com/alxgraphy/Mono-iOS/issues/new?template=bug_report.md)**

---

### Suggesting Features

We love feature suggestions! Before creating a feature request, check if it already exists.

#### Feature Request Template
```markdown
## Feature Name
Brief, descriptive title

## Problem Statement
Is your feature request related to a problem? Please describe.
Example: "I'm always frustrated when..."

## Proposed Solution
A clear and concise description of what you want to happen.

## Alternative Solutions
Describe any alternative solutions or features you've considered.

## Use Case
Who would benefit from this feature? How would they use it?

## Mockups/Examples
If applicable, add mockups, wireframes, or examples from other apps.

## Additional Context
Add any other context, screenshots, or references about the feature request.

## Priority
How important is this feature to you?
- [ ] Critical - Blocks my workflow
- [ ] High - Would significantly improve my experience
- [ ] Medium - Nice to have
- [ ] Low - Minor enhancement
```

**[Create Feature Request](https://github.com/alxgraphy/Mono-iOS/issues/new?template=feature_request.md)**

---

### Code Contributions

#### Types of Contributions We're Looking For

- 🐛 **Bug fixes** - Fix reported issues
- ✨ **New features** - Implement features from the roadmap
- 📝 **Documentation** - Improve README, comments, or guides
- 🎨 **UI/UX improvements** - Enhance design and user experience
- ⚡ **Performance** - Optimize code and reduce resource usage
- ♿ **Accessibility** - Improve VoiceOver and accessibility features
- 🌐 **Localization** - Add support for more languages

---

## Development Setup

### Prerequisites

- **macOS** 13.0 or later
- **Xcode** 15.0 or later
- **iOS Device** with iOS 16.1+ (for Live Activities testing)
- **Apple Developer Account** (free tier works)

### Getting Started

1. **Fork the repository**
```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/Mono-iOS.git
cd Mono-iOS
```

2. **Open in Xcode**
```bash
open "Mono iOS.xcodeproj"
```

3. **Configure signing**

- Select the project in Xcode
- Go to **Signing & Capabilities**
- Select your team
- Ensure **Automatically manage signing** is checked

4. **Build and run**
```bash
# In Xcode, press Cmd+R
# Or use command line:
xcodebuild -scheme "Mono iOS" -destination 'platform=iOS,name=Your iPhone'
```

### Project Structure
```
Mono iOS/
├── Models.swift              # Data models
├── TimerManager.swift        # Business logic
├── ContentView.swift         # Main UI
├── SettingsView.swift        # Settings UI
├── Mono_iOSApp.swift        # App entry
└── MonoWidget/              # Live Activities
```

---

## Pull Request Process

### Before Submitting

- [ ] Test on a physical iOS device (not just simulator)
- [ ] Verify Live Activities work correctly (if applicable)
- [ ] Check for compiler warnings
- [ ] Update documentation if needed
- [ ] Add/update tests if applicable

### Creating a Pull Request

1. **Create a feature branch**
```bash
git checkout -b feature/amazing-feature
```

2. **Make your changes**
```bash
# Make changes
git add .
git commit -m "Add amazing feature"
```

3. **Keep your branch updated**
```bash
git fetch upstream
git rebase upstream/main
```

4. **Push to your fork**
```bash
git push origin feature/amazing-feature
```

5. **Open a Pull Request**

Use this template:
```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] 📝 Documentation update
- [ ] 🎨 UI/UX improvement
- [ ] ⚡ Performance improvement

## Related Issue
Fixes #(issue number)

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing
How was this tested?
- [ ] Tested on iPhone (model: ___)
- [ ] Tested in dark mode
- [ ] Tested in light mode
- [ ] Tested Live Activities
- [ ] Tested landscape orientation

## Screenshots (if applicable)
Add screenshots of changes

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have tested on a physical device
```

### Review Process

1. A maintainer will review your PR within 1-3 days
2. Address any requested changes
3. Once approved, a maintainer will merge your PR
4. Your contribution will be in the next release! 🎉

---

## Style Guidelines

### Swift Code Style
```swift
// Use clear, descriptive names
func startTimerWithDuration(_ duration: Int) { }

// Prefer explicit types when clarity is needed
let timeRemaining: Int = 1500

// Use guard for early returns
guard timerManager.isRunning else { return }

// Use meaningful variable names
let totalSessionDuration = sessions.reduce(0) { $0 + $1.duration }

// Add comments for complex logic
// Calculate remaining time based on current timestamp
// and initial start time to account for background suspension
let remaining = startTime + duration - Date().timeIntervalSince1970
```

### SwiftUI Style
```swift
// Break down complex views into smaller components
struct StatRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
}

// Use meaningful animation parameters
.animation(.spring(response: 0.3, dampingFraction: 0.7), value: isActive)

// Group related modifiers
Text("Timer")
    .font(.system(size: 14))
    .foregroundColor(.primary)
    .padding()
```

### Commit Messages

Use conventional commits format:
```bash
# Feature
git commit -m "feat: add haptic feedback to timer completion"

# Bug fix
git commit -m "fix: resolve Live Activity not updating in background"

# Documentation
git commit -m "docs: update README with new screenshots"

# Style
git commit -m "style: format code according to Swift style guide"

# Refactor
git commit -m "refactor: extract timer logic into separate functions"

# Performance
git commit -m "perf: optimize session history rendering"

# Test
git commit -m "test: add unit tests for TimerManager"
```

---

## Community

### Questions?

- 💬 [GitHub Discussions](https://github.com/alxgraphy/Mono-iOS/discussions) - Ask questions
- 🐛 [GitHub Issues](https://github.com/alxgraphy/Mono-iOS/issues) - Report bugs
- 📧 Email: your-email@example.com

### Stay Updated

- ⭐ Star the repository to show support
- 👁️ Watch the repository for updates
- 🍴 Fork to contribute

---

## Recognition

All contributors will be recognized in our README and release notes!

### Contributors

Thank you to all our contributors! 🙏

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- This section is automatically generated -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to Mono!** 🎉

Every contribution, no matter how small, makes a difference.
