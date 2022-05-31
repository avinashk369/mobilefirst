import 'package:dio/dio.dart';
import 'package:mobilefirst/models/news/news_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mobilefirst/utils/utils.dart';
part 'ApiClient.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // get news list
  @GET("everything")
  Future<NewsModel> getNews(@Queries() Map<String, dynamic> queries);
}
