import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/pet/controllers/pet_controller.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core package
import 'firebase_options.dart'; // Import generated Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "com.example.mascotas_app",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(PetController(), permanent: true);
      }),
    ),
  );
}
