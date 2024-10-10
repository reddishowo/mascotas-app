import 'package:get/get.dart';

import '../controllers/articledetail_controller.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleDetailController>(() => ArticleDetailController());
  }
}
