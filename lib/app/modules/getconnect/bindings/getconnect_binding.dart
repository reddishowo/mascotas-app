import 'package:get/get.dart';

import '../controllers/getconnect_controller.dart';


class GetConnectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetConnectController>(
      () => GetConnectController(),
    );
  }
}