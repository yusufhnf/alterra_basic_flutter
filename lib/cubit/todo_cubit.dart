import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.dart';
part 'todo_cubit.freezed.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState.empty());

  List<String> todos = [];

  void addTodo({required String todoText}) {
    emit(const TodoState.initial());
    todos.add(todoText);
    emit(TodoState.loaded(data: todos));
  }

  void deleteTodoByIndex({required int index}) {
    emit(const TodoState.initial());
    todos.removeAt(index);
    if (todos.isEmpty) {
      emit(const TodoState.empty());
    } else {
      emit(TodoState.loaded(data: todos));
    }
  }
}
