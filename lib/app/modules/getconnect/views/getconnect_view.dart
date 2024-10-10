import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/getconnect_controller.dart';
import '../../articlecard/views/card_view.dart';

class GetConnectView extends GetView<GetConnectController> {
  const GetConnectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pastikan GetConnectController sudah diinisialisasi
    final GetConnectController controller = Get.put(GetConnectController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Page'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.secondary),
            ),
          );
        } else if (controller.articles.isEmpty) {
          return const Center(
            child: Text('No articles found'),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.articles.length,
            itemBuilder: (context, index) {
              var article = controller.articles[index];
              return CardArticle(article: article);
            },
          );
        }
      }),
    );
  }
}