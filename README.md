# Flutter App Starter - Appleton

A clean architecture Flutter starter project by Appleton.

## Overview

This repository contains a Flutter application structured with a clean architecture pattern, featuring:

- Authentication services
- Analytics tracking
- In-app purchases
- Localization support
- Configuration management

## Project Structure

```
lib/
├── configs/           # Environment and configuration constants
├── domain/            # Business logic
│   ├── audio/         # Audio services
│   ├── core/          # Core domain utilities
│   ├── features/      # App features
│   └── services/      # Business services (Auth, Analytics, IAP)
├── infrastructure/    # Data layer implementations
├── presentation/      # UI components and screens
├── main.dart          # Application entry point
└── initialization.dart # App initialization logic
```

## Technology Stack

- **State Management**: GetX
- **Backend Integration**: Supabase
- **Analytics**: Amplitude, Branch
- **IAP**: Adapty
- **Notifications**: OneSignal
- **Error Tracking**: Sentry

## Getting Started

### Prerequisites

- Flutter 3.29.2
- Dart SDK 3.6.0+

### Environment Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Set up environment variables:
   - Create a `.env` file based on the example file

### Running the App

```bash
flutter run
```

## Features

- **Authentication**: Sign-in with email, Apple, Google
- **Analytics**: Track user behavior and engagement
- **In-App Purchases**: Subscription management
- **Localization**: Multi-language support
- **Configuration**: Remote and local app configurations

## Architecture

The application follows a clean architecture pattern with:

- **Domain Layer**: Business logic and rules
- **Infrastructure Layer**: Data sources and repositories
- **Presentation Layer**: UI components and screens

## Development

### Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing

```bash
flutter test
```

## Deployment

### iOS

1. Update version in `pubspec.yaml`
2. Build the app:
   ```bash
   flutter build ios 
   ```
3. Upload to App Store Connect

### Android

1. Update version in `pubspec.yaml`
2. Build the app:
   ```bash
   flutter build appbundle
   ```
3. Upload to Google Play Console

## License

Proprietary - Appleton, Inc.

## About Appleton

[Appleton](https://appleton.studio) specializes in developing innovative mobile solutions.
