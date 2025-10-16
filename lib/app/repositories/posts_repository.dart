import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../models/post_model.dart';

class PostsRepository {
  final ApiService api;
  final LocalStorageService local;

  PostsRepository(this.api, this.local);

  Future<List<Post>> getLocalPosts() async {
    return await local.getAllPosts();
  }

  Future<List<Post>> fetchAndMergePosts() async {
    final remote = await api.fetchPosts();
    final localMap = { for (var p in await local.getAllPosts()) p.id : p };
    List<Post> result = [];
    for (var r in remote) {
      final id = r['id'] as int;
      if (localMap.containsKey(id)) {
        final lp = localMap[id]!;
        lp.title = r['title'] ?? lp.title;
        lp.body = r['body'] ?? lp.body;
        await local.savePost(lp);
        result.add(lp);
      } else {
        final post = Post.fromJson(r);
        await local.savePost(post);
        result.add(post);
      }
    }
    return result;
  }

  Future<void> persistPost(Post p) async {
    await local.savePost(p);
  }

  Future<void> markAsRead(int id) async {
    await local.markAsRead(id);
  }

  Future<void> persistElapsed(int id, int elapsed) async {
    await local.updateElapsed(id, elapsed);
  }

  Future<Post?> fetchPostById(int id) async {
    final map = await api.fetchPostById(id);
    if (map == null) return null;
    return Post.fromJson(map);
  }
}
