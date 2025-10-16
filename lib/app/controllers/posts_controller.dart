import 'dart:async';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../repositories/posts_repository.dart';

class PostsController extends GetxController {
  final PostsRepository repo;
  PostsController(this.repo);

  var posts = <Post>[].obs;
  var isLoading = false.obs;
  final Map<int, Timer> _activeTimers = {};

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    isLoading.value = true;
    final local = await repo.getLocalPosts();
    if (local.isNotEmpty) {
      posts.assignAll(local);
    }
    isLoading.value = false;
    // background sync
    syncWithApi();
  }

  Future<void> syncWithApi() async {
    try {
      final merged = await repo.fetchAndMergePosts();
      posts.assignAll(merged);
    } catch (e) {
      Get.snackbar('Sync failed', e.toString());
    }
  }

  void openPost(int id) {
  pauseTimerFor(id);
  final p = posts.firstWhereOrNull((e) => e.id == id);
  if (p == null) return;

  p.isRead = true;
  posts.refresh(); // Notify GetX observers
  repo.persistPost(p);

  Get.toNamed('/post', arguments: id);
}


  void startTimerFor(int id) {
    final p = posts.firstWhereOrNull((e) => e.id == id);
    if (p == null) return;
    if (_activeTimers.containsKey(id)) return;
    if (p.elapsedSeconds >= p.timerSeconds) return;
    _activeTimers[id] = Timer.periodic(Duration(seconds:1), (t) {
      p.elapsedSeconds++;
      posts.refresh();
      if (p.elapsedSeconds >= p.timerSeconds) {
        t.cancel();
        _activeTimers.remove(id);
        repo.persistPost(p);
      }
    });
  }

  void pauseTimerFor(int id) {
    if (_activeTimers.containsKey(id)) {
      _activeTimers[id]?.cancel();
      _activeTimers.remove(id);
      final p = posts.firstWhereOrNull((e) => e.id == id);
      if (p != null) repo.persistElapsed(id, p.elapsedSeconds);
    }
  }

  void disposeTimerFor(int id) {
    if (_activeTimers.containsKey(id)) {
      _activeTimers[id]?.cancel();
      _activeTimers.remove(id);
    }
  }

  @override
  void onClose() {
    _activeTimers.values.forEach((t) => t.cancel());
    super.onClose();
  }
}
