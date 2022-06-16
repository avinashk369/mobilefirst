part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitializing extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoError extends TodoState {
  String message;
  TodoError({required this.message});
  @override
  List<Object> get props => [message];
}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  const TodoLoaded({
    required this.todos,
  });

// this  copy with is used to copy the state and add the new data
  TodoLoaded copyWith({
    List<TodoModel>? todos,
    bool? hasReachedMax,
  }) {
    return TodoLoaded(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos];
}

class TodoAdded extends TodoState {
  final TodoModel todo;
  const TodoAdded({
    required this.todo,
  });
  @override
  List<Object> get props => [todo];
}
