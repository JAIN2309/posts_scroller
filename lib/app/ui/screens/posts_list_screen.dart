import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/posts_controller.dart';
import '../widgets/post_tile.dart';

class PostsListScreen extends StatelessWidget {
  final PostsController controller = Get.find<PostsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: Obx(() {
        if (controller.isLoading.value && controller.posts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () => controller.syncWithApi(),
          child: ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return VisibilityDetector(
                key: Key('post-\${post.id}'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0) {
                    controller.startTimerFor(post.id);
                  } else {
                    controller.pauseTimerFor(post.id);
                  }
                },
                child: PostTile(post: post),
              );
            },
          ),
        );
      }),
    );
  }
}
