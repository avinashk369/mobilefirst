import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobilefirst/apis/ApiClient.dart';
import 'package:mobilefirst/models/todo_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TodoRepositoryImpl {
  late Dio dio;
  late ApiClient apiClient;
  TodoRepositoryImpl() {
    dio = Dio();
    dio.options.headers["X-Parse-Client-Key"] = dotenv.env['CLIENT_KEY'];
    dio.options.headers["X-Parse-Application-Id"] = dotenv.env['APP_ID']!;
    //dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestBody: true,
    ));
    apiClient = ApiClient(dio);
  }
  //add todo
  Future<void> saveTodo(String title) async {
    final todo = ParseObject('Todo')
      ..set('title', title)
      ..set('done', false);
    await todo.save();
  }

  //load todos
  Future<TodoModel> getTodo() async {
    // QueryBuilder<ParseObject> queryTodo =
    //     QueryBuilder<ParseObject>(ParseObject('FirstClass'));
    // final ParseResponse apiResponse = await queryTodo.query();

    // if (apiResponse.success && apiResponse.results != null) {
    //   return apiResponse.results as List<TodoModel>;
    // } else {
    //   return [];
    // }
    late TodoModel todoList;
    try {
      todoList = await apiClient.getDietPlan("CBflLvCTXO");
      // await apiClient.saveDietPlan({
      //   "Name": "Hozefa",
      //   "Description": "Testing..."
      // });
      //await apiClient.deleteDietPlan("yHs0itDpkx");
      return todoList;
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      throw Exception("Something went wrong");
    }
  }

  // update todos
  Future<void> updateTodo(String id, bool done) async {
    var todo = ParseObject('Todo')
      ..objectId = id
      ..set('done', done);
    await todo.save();
  }

  // delete todos
  Future<void> deleteTodo(String id) async {
    await apiClient.deleteDietPlan(id);
  }

  //get single diet item
  Future<TodoModel> getDietPlan(String id) async {
    return await apiClient.getSingleDietPlan(id);
  }
}
