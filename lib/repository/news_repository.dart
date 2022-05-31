import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/models/news/news_model.dart';

abstract class NewsRepository {
  Future<NewsModel> loadNews(int page, int limit, String? title);
  Future<Articles> bookmarkNews(Articles article);
}
