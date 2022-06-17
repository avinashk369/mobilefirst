import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobilefirst/models/news/news_model.dart';
import 'package:mobilefirst/models/todo_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mobilefirst/utils/utils.dart';
part 'ApiClient.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // get news list
  @GET("everything")
  Future<NewsModel> getNews(@Queries() Map<String, dynamic> queries);

  @GET("https://parseapi.back4app.com/classes/Diet_Plans")
  Future<TodoModel> getDietPlan(@Path("objectId") String objectId);

  @POST("https://parseapi.back4app.com/classes/Diet_Plans")
  Future<TodoModel> saveDietPlan(@Body() Map<String, dynamic> data);

  @DELETE("https://parseapi.back4app.com/classes/Diet_Plans/{objectId}")
  Future<TodoModel> deleteDietPlan(@Path("objectId") String objectId);

  @GET("https://parseapi.back4app.com/classes/Diet_Plans/{objectId}")
  Future<TodoModel> getSingleDietPlan(@Path("objectId") String objectId);

}
