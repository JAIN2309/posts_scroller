import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/posts_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final PostsController controller = Get.find<PostsController>();

  @override
  Widget build(BuildContext context) {
    final id = Get.arguments as int?;
    if (id == null) return Scaffold(body: Center(child: Text('No post id')));
    final post = controller.posts.firstWhereOrNull((p) => p.id == id);
    return Scaffold(
      appBar: AppBar(title: Text(post?.title ?? 'Post')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: post == null
            ? Center(child: Text('Loading...'))
            : SingleChildScrollView(child: Text(post.body)),
      ),
    );
  }
}
