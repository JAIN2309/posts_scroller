# 📌 Posts Scroller App - Flutter + GetX (Skeleton)

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)](https://flutter.dev/)
[![GetX](https://img.shields.io/badge/GetX-State%20Management-orange)](https://pub.dev/packages/get)
[![Hive](https://img.shields.io/badge/Hive-Local%20Storage-yellowgreen)](https://pub.dev/packages/hive)

A **Flutter + GetX skeleton app** implementing the required architecture for an Assignment Task App.  
This project provides a solid foundation with reactive state management, Hive local storage, and per-item timers.

---

## 🗂 Features

- Reactive **GetX controllers** for state management
- **Hive local storage** service stubs
- **VisibilityDetector** for per-item timers
- Timer **start/pause/resume** logic in `PostsController`
- **Skeleton project** for easy extension and customization

---

## 📁 Project Structure

lib/
├── app/
│ ├── controllers/
│ │ └── posts_controller.dart
│ ├── models/
│ │ └── post_model.dart
│ ├── repositories/
│ │ └── posts_repository.dart
│ ├── services/
│ │ ├── api_service.dart
│ │ └── local_storage_service.dart
│ └── ui/
│ ├── screens/
│ │ ├── posts_list_screen.dart
│ │ └── post_detail_screen.dart
│ └── widgets/
│ └── post_tile.dart
├── main.dart

---

---

## ⚡ Getting Started

1. **Clone the repository:**

```bash
git clone <your-repo-url>
cd assignment_task_app
Install dependencies:

bash
Copy code
flutter pub get
Generate Hive TypeAdapters:

bash
Copy code
flutter packages pub run build_runner build
Initialize Hive in main.dart:

dart
Copy code
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>('posts_box');

  runApp(MyApp());
}
Run the app:

bash
Copy code
flutter run
📝 Notes
PostTile widget uses Obx to reactively update UI based on PostsController.posts.

Timers are handled in the controller and updated using posts.refresh().

Do not use .obs inside Hive models. Keep Hive fields plain Dart types.

Minor wiring may be required to run the app successfully on a device or emulator.

🚀 Next Steps
Implement PostsRepository.fetchAndMergePosts() for API syncing.

Add additional screens, e.g., Post creation or editing.

Enhance timer UI with animations or notifications.

Apply theming and UI improvements.

🛠 Technologies Used
Flutter 3.x+

GetX for state management and routing

Hive for local storage

VisibilityDetector for per-item timers

Dart 3.x

📦 GitHub Setup
Add .gitignore:

pgsql
Copy code
build/
.dart_tool/
.packages
pubspec.lock
.idea/
*.iml
*.log
Commit and push:

bash
Copy code
git add .
git commit -m "Initial Flutter Assignment Task App skeleton"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
