import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilefirst/models/ServerError.dart';
import 'package:mobilefirst/models/todo_model.dart';
import 'package:mobilefirst/repository/todo_repositoryImpl.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepositoryImpl _todoRepositoryImpl;

  TodoBloc(this._todoRepositoryImpl) : super(TodoInitializing()) {
    on<LoadTodos>((event, emit) => _loadTodos(event, emit));
    on<DeleteTodo>((event, emit) => _deleteTodo(event, emit));
  }
  // delete todo
  Future<void> _deleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      final state = this.state;
      if (state is TodoLoaded) {
        await _todoRepositoryImpl.deleteTodo(event.id);
        List<TodoModel> todos = state.todos
            .where((element) => element.objectId != event.id)
            .toList();
        emit(TodoLoaded(todos: todos));
      }
    } on ServerError catch (e) {
      emit(TodoError(message: e.toString()));
    } catch (e, stacktrace) {
      print("Error: $e stackTrace: $stacktrace");
      emit(TodoError(message: e.toString()));
    }
  }

  // save todo
  Future<void> _saveTodo(SaveTodo event, Emitter<TodoState> emit) async {
    try {
      final state = this.state;
      if (state is TodoLoaded) {}
    } catch (e) {}
  }

  //load todos
  Future _loadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    try {
      TodoModel todos = await _todoRepositoryImpl.getTodo();

      emit(TodoLoaded(todos: todos.results!));
    } on ServerError catch (e) {
      print(e.getErrorMessage());
      emit(TodoError(message: e.getErrorMessage()));
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      emit(TodoError(message: e.toString()));
    }
  }
}
