# Mono - A Brutalist Timer for Focus

A minimalist timer and stopwatch app for iOS with a clean, modern interface and Live Activities support.

![iOS Badge](https://img.shields.io/badge/iOS-16.1%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)
- [Customization](#customization)
- [Technologies](#technologies)
- [Contributing](#contributing)
- [Known Issues](#known-issues)
- [Roadmap](#roadmap)
- [License](#license)
- [Author](#author)
- [Support](#support)

---

## Features

- **Timer & Stopwatch** - Dual mode functionality in one app
- **Live Activities** - See your timer/stopwatch on your lock screen and Dynamic Island
- **Landscape Optimized** - Designed specifically for landscape viewing
- **Dark/Light Themes** - Beautiful themes that adapt to your preference
- **Session History** - Track your productivity with automatic session logging
- **Statistics** - View your total sessions, time spent, and longest session
- **Modern iOS Design** - Clean, brutalist aesthetic with smooth animations
- **Editable Timers** - Tap the timer to quickly edit duration

---

## Screenshots

<p align="center">
  <img width="45%" alt="Timer Mode Dark" src="https://github.com/user-attachments/assets/0f1ae7de-7a1d-4f3a-afee-97767d99e7ec" />
  <img width="45%" alt="Timer Running Light" src="https://github.com/user-attachments/assets/6bd4081f-9470-4f79-b5d8-b88487f2e38c" />
</p>

**Left:** Timer paused in dark mode | **Right:** Timer running with live statistics in light mode

---

## Requirements

- iOS 16.1 or later
- iPad (landscape mode)
- Xcode 15+ (for development)

---

## Installation

### From Source
```bash
# Clone the repository
git clone https://github.com/alxgraphy/Mono-iOS.git

# Navigate to project directory
cd Mono-iOS

# Open in Xcode
open "Mono iOS.xcodeproj"
```

### Steps

1. Select your development team in **Signing & Capabilities**
2. Connect your iPhone via USB
3. Select your device in Xcode's device dropdown
4. Build and run on your device (`Cmd+R`)

> **Note:** Live Activities only work on physical devices, not simulators.

---

## Usage

### Timer Mode

1. Tap **Timer** at the top
2. Tap the time display to edit duration
3. Press **Play** to start
4. Press **Pause** to pause
5. Press **Reset** to reset to default (25:00)

### Stopwatch Mode

1. Tap **Stopwatch** at the top
2. Press **Play** to start counting
3. Press **Pause** to pause
4. Press **Reset** to reset to 00:00

### Live Activities

When you start a timer or stopwatch and exit the app:

- **Lock Screen:** Full Live Activity widget shows current time
- **Dynamic Island:** Compact timer display in the Dynamic Island
- **Expanded View:** Tap to see full controls

**Displays:**
- Current time remaining/elapsed
- Play/pause state
- Timer/stopwatch mode

### Statistics

When running, the statistics panel slides in from the right:

- **Total Sessions** - Number of completed sessions
- **Total Time** - Cumulative time tracked
- **Longest Session** - Your longest continuous session
- **Recent 5** - Last 5 sessions with timestamps

---

## Architecture
```
Mono iOS/
├── Models.swift                      # Data models
│   ├── AppMode (timer/stopwatch)
│   ├── Theme (dark/light)
│   ├── SessionRecord
│   └── FocusSchedule
│
├── TimerManager.swift                # Core logic
│   ├── Timer/Stopwatch state management
│   ├── Live Activity integration
│   ├── Session history tracking
│   └── Notification handling
│
├── ContentView.swift                 # Main UI
│   ├── Timer display
│   ├── Mode selection
│   ├── Control buttons
│   └── Statistics panel
│
├── SettingsView.swift                # Settings
│   ├── Theme preferences
│   ├── Default mode selection
│   └── Feature toggles
│
├── Mono_iOSApp.swift                # App entry point
│
└── MonoWidget/                      # Live Activity extension
    ├── TimerActivityAttributes.swift # Activity data model
    └── MonoWidget.swift              # Lock screen widget UI
```

### Key Components
```swift
// Timer state management with Combine
private var timer: AnyCancellable?

// Live Activity integration
private var currentActivity: Activity<TimerActivityAttributes>?

// Session tracking
@Published var history: [SessionRecord] = []
```

---

## Customization

### Themes

**Toggle Theme:**
- Tap the sun/moon icon (top right when timer is running)
- Switches between dark and light modes

**Auto Theme:**
- Enable in Settings to follow system theme
- Automatically switches based on iOS appearance

### Settings

Access via the gear icon:

- **Default Mode** - Choose Timer or Stopwatch as startup mode
- **Default Theme** - Set preferred theme (Dark/Light)
- **Auto Switch Theme** - Follow system appearance
- **Timer Auto Repeat** - Automatically restart timer when complete
- **Show Pizzazz** - Toggle visual effects and animations

---

## Technologies

| Technology | Purpose |
|-----------|---------|
| **SwiftUI** | Modern declarative UI framework |
| **Combine** | Reactive timer implementation |
| **ActivityKit** | Live Activities support |
| **WidgetKit** | Widget extension for lock screen |
| **UserNotifications** | Timer completion alerts |
| **AudioToolbox** | Completion sound effects |

---

## Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to get started.

### Quick Links

- 🐛 [Report a Bug](https://github.com/alxgraphy/Mono-iOS/issues/new?template=bug_report.md)
- ✨ [Request a Feature](https://github.com/alxgraphy/Mono-iOS/issues/new?template=feature_request.md)
- 💬 [Discussions](https://github.com/alxgraphy/Mono-iOS/discussions)
- 📖 [Contributing Guide](CONTRIBUTING.md)

### How to Contribute
```bash
# Fork the repository, then clone your fork
git clone https://github.com/YOUR_USERNAME/Mono-iOS.git
cd Mono-iOS

# Create a feature branch
git checkout -b feature/amazing-feature

# Make your changes and commit
git commit -m 'Add some amazing feature'

# Push to your fork
git push origin feature/amazing-feature

# Open a Pull Request on GitHub
```

### Guidelines

- Follow Swift style guide
- Test on physical device (Live Activities)
- Update documentation if adding features
- Keep commits focused and descriptive

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## Known Issues

### Live Activities
```
Error: unsupportedTarget on simulators
Cause: ActivityKit not supported in iOS Simulator
Solution: Test on physical iPhone with iOS 16.1+
```

### Statistics
```
Issue: Session history clears on app restart
Status: Planned fix with CoreData persistence
Workaround: Keep app in background to retain history
```

---

## Roadmap

### Version 2.0
- [ ] **Persistent Storage** - CoreData integration for session history
- [ ] **Export Data** - CSV/JSON export of session data
- [ ] **Custom Presets** - User-defined timer durations
- [ ] **Custom Sounds** - Choose notification sounds

### Version 2.1
- [ ] **Home Screen Widget** - Quick timer start from home screen
- [ ] **Apple Watch App** - Companion watchOS app
- [ ] **iPad Support** - Optimized layout for iPad

### Version 2.2
- [ ] **Haptic Feedback** - Enhanced tactile responses
- [ ] **Focus Mode Integration** - iOS Focus mode support
- [ ] **Siri Shortcuts** - Voice command support
- [ ] **CloudKit Sync** - Sync across devices

### Future
- [ ] **Themes Library** - More color schemes
- [ ] **Ambient Sounds** - Background focus sounds
- [ ] **Pomodoro Mode** - Built-in Pomodoro technique
- [ ] **Analytics Dashboard** - Detailed productivity insights

---

## License
```
MIT License

Copyright (c) 2026 Alexander Wondwossen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## Author

**Alexander Wondwossen**

- GitHub: [@alxgraphy](https://github.com/alxgraphy)
- Location: Toronto, Canada 🇨🇦

Made with ❤️

---

## Support

### Get Help

- **Issues:** [GitHub Issues](https://github.com/alxgraphy/Mono-iOS/issues)
- **Discussions:** [GitHub Discussions](https://github.com/alxgraphy/Mono-iOS/discussions)
- **Email:** your-email@example.com

### Reporting Bugs

When reporting bugs, include:
```
Device: iPhone 15 Pro
iOS Version: 17.2
App Version: 1.0.0
Issue: Brief description
Steps to Reproduce:
1. Step one
2. Step two
3. ...
```

Use our [Bug Report Template](https://github.com/alxgraphy/Mono-iOS/issues/new?template=bug_report.md)

### Feature Requests

Have an idea? Use our [Feature Request Template](https://github.com/alxgraphy/Mono-iOS/issues/new?template=feature_request.md)

Include:
- **Feature Name:** Brief title
- **Description:** What should it do?
- **Use Case:** Why is it useful?
- **Mockups:** (Optional) Visual examples

---

## Show Your Support

Give a ⭐️ if this project helped you!

---

## Contributors

Thank you to all our contributors! 🙏

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- This section is automatically generated -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

---

**Mono** - Focus on what matters.
