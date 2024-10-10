import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../login/views/login_view.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Background color for splash screen
      body: Center(
        child: FlutterSplashScreen.gif(
          useImmersiveMode: true,
          gifPath: 'assets/videos/splash_screen.gif',  // Path to your GIF
          gifWidth: 429,
          gifHeight: 931,
          nextScreen: const LoginView(),  // Next screen after the splash (replace with your login screen)
          duration: const Duration(milliseconds: 3515),  // Splash screen duration
          onInit: () async {
            debugPrint("Splash screen initialized");
          },
          onEnd: () async {
            debugPrint("Splash screen ended");
            controller.navigateToHome();  // Navigate to login after splash screen
          },
        ),
      ),
    );
  }
}
