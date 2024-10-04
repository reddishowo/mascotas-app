import 'package:get/get.dart';
import 'package:mobile_app_backup/app/modules/pet/controllers/pet_controller.dart';

class PetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetController>(
      () => PetController(),
    );
  }
}
