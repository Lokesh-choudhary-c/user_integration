import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc_api/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers,
        transformer: debounce(const Duration(milliseconds: 300)));
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await repository.fetchUsers(limit: event.limit, skip: event.skip);
      emit(UserLoaded(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await repository.searchUsers(event.query);
      emit(UserLoaded(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
