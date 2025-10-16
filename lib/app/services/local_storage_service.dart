import 'package:hive/hive.dart';
import '../models/post_model.dart';

class LocalStorageService {
  static const String boxName = 'posts_box';
  Future<Box> _openBox() async {
    return await Hive.openBox(boxName);
  }

  Future<List<Post>> getAllPosts() async {
    final box = await _openBox();
    return box.values.cast<Post>().toList();
  }

  Future<void> savePost(Post p) async {
    final box = await _openBox();
    await box.put(p.id, p);
  }

  Future<void> markAsRead(int id) async {
    final box = await _openBox();
    final p = box.get(id) as Post?;
    if (p != null) {
      p.isRead = true;
      await p.save();
    }
  }

  Future<void> updateElapsed(int id, int elapsed) async {
    final box = await _openBox();
    final p = box.get(id) as Post?;
    if (p != null) {
      p.elapsedSeconds = elapsed;
      await p.save();
    }
  }
}
