import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/posts_controller.dart';
import '../../models/post_model.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final PostsController controller = Get.find<PostsController>();

  PostTile({required this.post});

  String formatRemaining(int remaining) {
    final mm = (remaining ~/ 60).toString().padLeft(2,'0');
    final ss = (remaining % 60).toString().padLeft(2,'0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Access the post from the reactive list
      final p = controller.posts.firstWhere((e) => e.id == post.id);
      final remaining = p.timerSeconds - p.elapsedSeconds;

      return InkWell(
        onTap: () => controller.openPost(p.id),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          color: p.isRead ? Colors.white : Color(0xFFFFF9C4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(p.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Column(
                children: [
                  Text(formatRemaining(remaining)),
                  SizedBox(height: 6),
                  SizedBox(
                    width: 32, height: 32,
                    child: CircularProgressIndicator(
                      value: (p.elapsedSeconds / (p.timerSeconds == 0 ? 1 : p.timerSeconds)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
