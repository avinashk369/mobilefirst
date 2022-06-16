part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class LoadTodos extends TodoEvent {
  const LoadTodos();
  @override
  List<Object> get props => [];
}

class SaveTodo extends TodoEvent {
  final TodoModel todo;
  SaveTodo(this.todo);
  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;
  UpdateTodo(this.todo);
  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final TodoModel todo;
  DeleteTodo(this.todo);
  @override
  List<Object> get props => [todo];
}
