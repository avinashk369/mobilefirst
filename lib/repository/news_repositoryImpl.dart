import 'package:dio/dio.dart';
import 'package:mobilefirst/apis/ApiClient.dart';
import 'package:mobilefirst/db/db_helper.dart';
import 'package:mobilefirst/models/ServerError.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/models/news/news_model.dart';
import 'package:mobilefirst/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  late Dio dio;
  late ApiClient apiClient;
  NewsRepositoryImpl() {
    dio = Dio();
    //dio.options.headers["Content-Type"] = "application/json";
    //dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestBody: true,
    ));
    apiClient = ApiClient(dio);
  }
//f191d7c85a504246ad2d0f499713ae2c

  @override
  Future<NewsModel> loadNews(int page, int limit, String? title) async {
    late NewsModel news;
    try {
      Map<String, dynamic> queries = {
        //"country": "in",
        "apiKey": "f191d7c85a504246ad2d0f499713ae2c",
        "limit": limit,
        "page": page
      };
      queries["q"] = title ?? "bitcoin";
      news = await apiClient.getNews(queries);
    } catch (error) {
      throw ServerError.withError(error: error);
    }
    return news;
  }

  @override
  Future<Articles> bookmarkNews(Articles article) async {
    late Articles articles;
    try {
      // make a entry in the database and return the article with added value that article has been bookmarked

      articles = Articles();

      articles.title = article.title ?? "";
      articles.urlToImage = article.urlToImage ?? "";
      articles.author = article.author ?? "";
      articles.status = 1;
      articles = await DbHeler.instance.insertBookmark(articles);
    } catch (e) {
      throw Exception(e.toString());
    }
    return articles;
  }

  @override
  Future<List<Articles>> getBookmarkNews() async {
    try {
      return await DbHeler.instance.getBookmarkedArticles();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
