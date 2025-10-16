import 'package:get/get.dart';
import '../ui/screens/posts_list_screen.dart';
import '../ui/screens/post_detail_screen.dart';

abstract class Routes {
  static const POSTS = '/';
  static const POST_DETAIL = '/post';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.POSTS, page: () => PostsListScreen()),
    GetPage(name: Routes.POST_DETAIL, page: () => PostDetailScreen()),
  ];
}
