## Aurora Mobile Engineer Assignment

Tiny mobile app that fetches a random image from an API and displays it centered as a square. A button loads another image. The background adapts to the image’s colors for an immersive effect.

## Goal

- **Single screen UI**
- **Square image** centered on screen
- **Background color** adapts to the image
- **“Another”** button below the image fetches a new one

## API

- **Endpoint**: `GET https://november7-730026606190.europe-west1.run.app/image`
- **Docs**: `https://november7-730026606190.europe-west1.run.app/docs#/default/get_random_image_image__get`
- **Example response**:

```json
{ "url": "https://images.unsplash.com/photo-1506744038136-46273834b3fb" }
```

Notes:
- CORS is enabled server-side.
- URLs point to Unsplash; treat them as large, remote images (use caching/placeholder strategies).

## Requirements

- **UI**: Single screen, square image centered, “Another” button
- **Background**: Adapts to image colors
- **Fetching**: Tapping the button triggers a new `GET /image` and updates the image
- **Loading state**: Show while fetching
- **Errors**: Handle gracefully (message + retry)
- **Polish**:
  - Smooth transitions (fade image in; animate background color change)
  - Respect light/dark mode
  - Basic accessibility (labels, contrast, semantics/announcements)

## Implementation Notes

- **Image loading**: Use a cached network strategy and a lightweight placeholder/shimmer
- **Transitions**: 
  - Fade in the new image on load completion
  - Animate background color between images
- **Accessibility**:
  - Provide accessible labels (e.g., “Another image”)
  - Ensure button tap target and contrast are sufficient
  - Announce loading and errors to assistive tech
- **Error handling**:
  - Show a user-friendly message and a retry affordance
  - Keep last successful image visible if possible

## Run the App

### Prerequisites
- Flutter 3.x (Dart 3.x)
- Xcode (for iOS), Android Studio/SDK (for Android)

### Install and run
```bash
flutter pub get
flutter run
```

### iOS specific
- First build may require CocoaPods:
```bash
cd ios && pod install && cd ..
```
- Select device:
```bash
flutter devices
flutter run -d <device_id>
```

## Important iOS Notes

- **Build and test on a real iOS device for haptics.** Simulators do not reflect haptic feedback behavior.
- **Update signing to your account**:
  1. Open `ios/Runner.xcworkspace` in Xcode
  2. Select the `Runner` target → `Signing & Capabilities`
  3. Choose your Apple Developer Team and ensure a valid bundle identifier
  4. Let Xcode manage signing or provide the proper profiles



