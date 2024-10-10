import 'package:get/get.dart';
import '../controllers/petdetail_controller.dart';

class PetDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetDetailController>(
      () => PetDetailController(),
    );
  }
}