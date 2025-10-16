import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/bindings/initial_binding.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/screens/posts_list_screen.dart';
import 'app/models/post_model.dart'; // ✅ import model
// ✅ import generated adapter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // ✅ Register the adapter before opening any boxes
  Hive.registerAdapter(PostAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Assignment Task App',
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.POSTS,
      getPages: AppPages.pages,
    );
  }
}
