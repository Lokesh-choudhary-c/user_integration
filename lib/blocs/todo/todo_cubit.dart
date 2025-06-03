import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc_api/repositories/user_repository.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserRepository repository;

  TodoCubit(this.repository) : super(TodoInitial());

  Future<void> fetchTodos(int userId) async {
    emit(TodoLoading());
    try {
      final todos = await repository.fetchTodos(userId);
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }
}
