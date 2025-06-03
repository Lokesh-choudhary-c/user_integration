import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc_api/models/post_model.dart';
import 'package:users_bloc_api/repositories/user_repository.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final UserRepository repository;

  PostCubit(this.repository) : super(PostInitial());

  Future<void> fetchPosts(int userId) async {
    emit(PostLoading());
    try {
      final posts = await repository.fetchPosts(userId);
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  void addPost(Post post) {
    if (state is PostLoaded) {
      final updatedPosts = List<Post>.from((state as PostLoaded).posts)..insert(0, post);
      emit(PostLoaded(posts: updatedPosts));
    }
  }
}
