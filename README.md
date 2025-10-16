# Assignment Task App - Flutter + GetX (Skeleton)

This repository is an auto-generated skeleton implementing the required architecture for the Assignment Task App.
It contains:
- GetX controllers
- Hive local storage service stubs
- VisibilityDetector usage for per-item timers
- Timer start/pause/resume logic in PostsController

IMPORTANT:
- This is a **skeleton** to accelerate development. Some parts (like Hive TypeAdapters and generated files) are placeholders.
- To run:
  1. Install Flutter SDK.
  2. In project root: `flutter pub get`
  3. Register Hive TypeAdapter for Post (generate with build_runner) and open boxes in `main.dart`.
  4. Run: `flutter run`

Files of interest:
- lib/app/controllers/posts_controller.dart
- lib/app/repositories/posts_repository.dart
- lib/app/services/api_service.dart
- lib/app/services/local_storage_service.dart
- lib/app/models/post_model.dart
- lib/app/ui/screens/posts_list_screen.dart
- lib/app/ui/screens/post_detail_screen.dart
- lib/app/ui/widgets/post_tile.dart

This package is delivered as a zip. Please complete Hive adapter generation and minor wiring to run on a device/emulator.
