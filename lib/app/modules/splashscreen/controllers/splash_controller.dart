// File 2: /lib/app/modules/splashscreen/controllers/splash_controller.dart

import 'package:get/get.dart';

class SplashController extends GetxController {
  bool _hasNavigated = false;  // Prevent double navigation

  @override
  void onReady() {
    super.onReady();
    navigateToHome();
  }

  void navigateToHome() async {
    if (!_hasNavigated) {
      _hasNavigated = true;  // Set to true to avoid repeated navigation
      await Future.delayed(const Duration(seconds: 3));  // Simulate splash screen delay
      Get.offNamed('/login');  // Navigate to the login screen
    }
  }
}
