import 'package:get/get.dart';
import '../controllers/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    // Bind the ShopController when the shop view is accessed
    Get.lazyPut<ShopController>(() => ShopController());
  }
}
