import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/articles.dart';
import '../controllers/articledetail_controller.dart';
import 'articledetail_webview.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  final Article article;
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header mirip seperti di home_view.dart
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              color: Colors.white,
              child: Row(
                children: [
                  const Text(
                    'News App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/icons/cat_icon.png',
                    height: 24,
                    width: 24,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),

            // Image Section
            Hero(
              tag: article.urlToImage,
              // ignore: unnecessary_null_comparison
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.grey,
                      height: 200,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          'No Image',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Detail Article Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Date: ${article.publishedAt}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,  // This ensures text doesn't overflow
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.person, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Author: ${article.author}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,  // This ensures text doesn't overflow
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),

                  // Description
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Content
                  Text(
                    article.content,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Button Read More
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ArticleDetailWebView(article: article));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: const Size(double.infinity, 50), // Make button full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Read more',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
