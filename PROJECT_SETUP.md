# HarvestPro - Project Setup & Architecture

## Toolchain & Versions
- **Flutter**: Latest stable channel (3.24+ expected)
- **Dart**: Latest stable
- **Android minSdkVersion**: 24 (Targeting low-end 2GB RAM devices while allowing modern plugins to compile)

## Running & Testing

**To run the app locally:**
```bash
flutter run
```

**To run static analysis (Linting):**
```bash
flutter analyze
```
*(The project enforces strict linting via `analysis_options.yaml` - zero warnings allowed.)*

**To run unit and widget tests:**
```bash
flutter test
```

## Dependencies & Justifications

The following dependencies are selected based on the Section 6.1 constraints:

- **`flutter_riverpod`**: Compile-safe, testable, and scales cleanly from a simple mock-data frontend to a live-data app without a rewrite.
- **`hive` & `hive_flutter`**: Lightweight, fast key-value/relational storage for caching the last known advisory and queued outbound data (photos, check-ins) while offline. (Supports AES-256 encryption).
- **`flutter_localizations` & `intl`**: Native Flutter i18n plumbing; bundling the type families keeps rendering consistent across devices instead of falling back to system fonts.
- **`flutter_tts`**: On-device narration in the selected regional language without needing network access.
- **`speech_to_text`**: Voice input as the primary alternative to typing throughout the app.
- **`camera`**: Full control over the capture UI shown in Screen 3, and keeps uploads small on limited data plans.
- **`image`**: Compression before any upload.
- **`connectivity_plus`**: Detects online/offline transitions to trigger the offline state and background sync.
- **`go_router`**: Declarative, deep-link-friendly routing; keeps the 4-tab + modal-flow structure simple to maintain.
- **`permission_handler`**: Provides a clean interface for Just-In-Time permission prompts for camera, mic, and location.
