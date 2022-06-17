import 'package:bloc/bloc.dart';
import 'package:mobilefirst/models/todo_model.dart';

class NavBloc extends Cubit<TodoModel> {
  NavBloc()
      : super(TodoModel()
          ..name = "Page1"
          ..carbs = 0);

  Future<void> changeNavigation(String page, int index) async {
    try {
      TodoModel model = TodoModel()
        ..name = page
        ..carbs = index;
      emit(model);
    } catch (_) {}
  }
}
