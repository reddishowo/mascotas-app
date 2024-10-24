import 'package:get/get.dart';

import '../../register/controllers/authentication_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
