import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/articles.dart';
import '../../article_details/controllers/articledetail_controller.dart';
import '../../article_details/views/articledetail_view.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            if (isWideScreen) {
              // Inisialisasi controller sebelum menampilkan dialog
              Get.put(ArticleDetailController());
              
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: ArticleDetailPage(article: article),
                ),
              );
            } else {
              // Inisialisasi controller sebelum navigasi
              Get.put(ArticleDetailController());
              
              Get.to(() => ArticleDetailPage(article: article));
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Hero(
                  tag: article.id.toString(),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: article.urlToImage.isNotEmpty
                        ? Image.network(
                            article.urlToImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey,
                                child: const Center(
                                  child: Text('Image Error'),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey,
                            child: const Center(
                              child: Text(
                                'No Image',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              // Content Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(article.author, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Published: ${article.publishedAt.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
