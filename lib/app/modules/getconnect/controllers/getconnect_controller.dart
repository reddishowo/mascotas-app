import 'package:get/get.dart';
import '../../../data/models/articles.dart';

class GetConnectController extends GetxController {
  static const String _baseUrl = 'https://my-json-server.typicode.com/Fallid/codelab-api/';
  
  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    print('GetConnectController initialized');
    fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      print('Fetching articles...');
      isLoading.value = true;
      final response = await GetConnect().get(
        '${_baseUrl}db',
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final articlesData = response.body['articles'] as List;
        final articlesList = articlesData.map((articleJson) => Article.fromJson(articleJson)).toList();
        if (articlesList.isNotEmpty) {
          articles.assignAll(articlesList);
          print('Articles fetched: ${articles.length}');
        } else {
          print('No articles found');
        }
      } else {
        print("Request failed with status ${response.statusCode}");
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
      print('Finished fetching articles');
    }
  }
}
