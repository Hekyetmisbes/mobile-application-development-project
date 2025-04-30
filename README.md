# Flutter Web Image Downloader

A minimalist Flutter **web** application that lets users paste an image URL, preview it instantly, and download it to their device with a single click. Built for the "Mobile Application Development" course as a lightweight utility demonstrating Flutter’s web‑only target.

https://github.com/user-attachments/assets/3cad8122-12e5-4b89-9a0c-7daca12f98b4

---

## Getting Started

Follow the steps below to set up and run the project.

### Prerequisites
- Install Flutter ≥ 3.29: <https://docs.flutter.dev/get-started/install>
- Install Git: <https://git-scm.com/downloads>
- A modern browser (Chrome recommended)

### Setup and Run
```bash
# Clone the repository
git clone https://github.com/your-username/flutter_web_image_downloader.git
cd flutter_web_image_downloader

# Get dependencies
flutter pub get

# Run the app in debug mode (Chrome)
flutter run -d chrome

# Build for web (release)
flutter build web
```

### Development Commands
```bash
# Verify Flutter installation
flutter doctor

# Analyze project for issues
flutter analyze

# Run tests (if any)
flutter test
```

---

## Tech Stack
- **Flutter 3.29 (web)** – UI framework
- **Dart 3** – Programming language
- **image_downloader_web** – Browser download API wrapper
- **cached_network_image** – Image preview with caching
- **google_fonts** – Typography (Poppins)
- **flutter_spinkit** – Loading animations

---

## Features
- Real‑time image preview as you type
- One‑click download to the browser’s default directory
- Elegant Material 3 interface with Google Fonts
- 100 % web—no Android Studio or Xcode required
