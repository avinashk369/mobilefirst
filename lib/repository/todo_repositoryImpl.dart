import 'package:dio/dio.dart';
import 'package:mobilefirst/apis/ApiClient.dart';
import 'package:mobilefirst/models/todo_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TodoRepositoryImpl {
  late Dio dio;
  late ApiClient apiClient;
  TodoRepositoryImpl() {
    dio = Dio();
    dio.options.headers["X-Parse-Client-Key"] =
        "URq27vXJwxgUBcPuWWOOLH2w7y7V8JsuyoLFxAFO";
    dio.options.headers["X-Parse-Application-Id"] =
        "aPVFCkwUWwdHYL5A5qXPjVXdRK82s0Otz1LrlZyd";
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
    var todo = ParseObject('Todo')..objectId = id;
    await todo.delete();
  }
}
