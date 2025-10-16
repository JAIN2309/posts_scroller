import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../repositories/posts_repository.dart';
import '../controllers/posts_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<LocalStorageService>(() => LocalStorageService());
    Get.lazyPut<PostsRepository>(() => PostsRepository(Get.find(), Get.find()));
    Get.put<PostsController>(PostsController(Get.find()));
  }
}
