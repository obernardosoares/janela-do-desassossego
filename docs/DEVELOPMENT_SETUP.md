# Development Environment Setup

Quick start guides for setting up the Flutter development environment.

---

## Ubuntu / Linux

### 1. Install Flutter SDK

```bash
# Install dependencies
sudo apt update
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev

# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc)
echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter doctor
```

### 2. Android Studio + Emulator

```bash
# Install via snap
sudo snap install android-studio --classic

# Open Android Studio, install:
# - Android SDK
# - Android SDK Command-line Tools
# - Android Emulator

# Accept licenses
flutter doctor --android-licenses

# Verify
flutter doctor
```

### 3. VS Code Setup (Recommended)

```bash
sudo snap install code --classic
code --install-extension Dart-Code.flutter
```

### 4. Run Project

```bash
cd janela-do-desassossego
flutter pub get
flutter run
```

---

## macOS

### 1. Install Flutter SDK

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Flutter
brew install flutter

# Or manual install
cd ~
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$HOME/flutter/bin:$PATH"

# Verify
flutter doctor
```

### 2. Xcode (iOS Development)

```bash
# Install Xcode from App Store, then:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Install CocoaPods
brew install cocoapods

# Accept licenses
sudo xcodebuild -license accept

# iOS Simulator
open -a Simulator
```

### 3. Android Studio

```bash
brew install --cask android-studio
flutter doctor --android-licenses
```

### 4. Verify

```bash
flutter doctor
# Should show ✓ for Flutter, Android, iOS (Xcode)
```

---

## Windows

### 1. Install Flutter SDK

```powershell
# Install Git for Windows first: https://git-scm.com/download/win

# Download Flutter SDK
# https://docs.flutter.dev/get-started/install/windows

# Extract to C:\flutter
# Add C:\flutter\bin to PATH

# Verify in PowerShell
flutter doctor
```

### 2. Android Studio

1. Download from https://developer.android.com/studio
2. Install Android SDK, Command-line Tools, Emulator
3. Run: `flutter doctor --android-licenses`

### 3. VS Code

```powershell
winget install Microsoft.VisualStudioCode
code --install-extension Dart-Code.flutter
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `flutter doctor` | Check environment |
| `flutter create app_name` | New project |
| `flutter pub get` | Install dependencies |
| `flutter run` | Run on connected device |
| `flutter run -d chrome` | Run on web |
| `flutter test` | Run tests |
| `flutter build apk` | Build Android APK |
| `flutter build ios` | Build iOS (macOS only) |

---

## Troubleshooting

### Linux: Chrome not found
```bash
sudo apt install chromium-browser
```

### Android: No devices
```bash
flutter emulators --create --name test_emulator
flutter emulators --launch test_emulator
```

### iOS: Pod install fails
```bash
cd ios && pod repo update && pod install
```
