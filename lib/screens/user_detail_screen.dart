import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc_api/blocs/post/post_cubit.dart';
import 'package:users_bloc_api/blocs/post/post_state.dart';
import 'package:users_bloc_api/blocs/todo/todo_cubit.dart';
import 'package:users_bloc_api/blocs/todo/todo_state.dart';
import 'package:users_bloc_api/models/post_model.dart';
import 'package:users_bloc_api/models/user_model.dart';
import 'package:users_bloc_api/repositories/user_repository.dart';
import 'package:users_bloc_api/screens/create_post.dart';


class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late final PostCubit _postCubit;
  late final TodoCubit _todoCubit;
  final UserRepository _repository = UserRepository();

  @override
  void initState() {
    super.initState();
    _postCubit = PostCubit(_repository);
    _todoCubit = TodoCubit(_repository);

    _postCubit.fetchPosts(widget.user.id);
    _todoCubit.fetchTodos(widget.user.id);
  }

  @override
  void dispose() {
    _postCubit.close();
    _todoCubit.close();
    super.dispose();
  }

  void _navigateToCreatePost() async {
    final newPost = await Navigator.push<Post>(
      context,
      MaterialPageRoute(
        builder: (_) => CreatePostScreen(userId: widget.user.id),
      ),
    );

    if (newPost != null) {
      _postCubit.addPost(newPost);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>.value(value: _postCubit),
        BlocProvider<TodoCubit>.value(value: _todoCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.fullName),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _navigateToCreatePost,
              tooltip: 'Create Post',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.image),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.fullName, style: Theme.of(context).textTheme.titleLarge),
                        Text(user.email, style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Posts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostLoaded) {
                    if (state.posts.isEmpty) {
                      return const Text('No posts found.');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(post.title),
                            subtitle: Text(post.body),
                          ),
                        );
                      },
                    );
                  } else if (state is PostError) {
                    return Text('Error: ${state.message}');
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
              const Text('Todos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodoLoaded) {
                    if (state.todos.isEmpty) {
                      return const Text('No todos found.');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return CheckboxListTile(
                          value: todo.completed,
                          onChanged: null,
                          title: Text(todo.todo),
                        );
                      },
                    );
                  } else if (state is TodoError) {
                    return Text('Error: ${state.message}');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
