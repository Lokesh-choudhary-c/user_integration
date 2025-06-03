import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:users_bloc_api/models/post_model.dart';
import 'package:users_bloc_api/models/todo_model.dart';
import 'package:users_bloc_api/models/user_model.dart';


class UserRepository {
  static const baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers({int limit = 20, int skip = 0}) async {
    final response = await http.get(Uri.parse('$baseUrl/users?limit=$limit&skip=$skip'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List usersJson = data['users'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<List<User>> searchUsers(String query) async {
    if (query.isEmpty) {
      return fetchUsers();
    }
    final response = await http.get(Uri.parse('$baseUrl/users/search?q=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List usersJson = data['users'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }

  Future<List<Post>> fetchPosts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List postsJson = data['posts'];
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<List<Todo>> fetchTodos(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List todosJson = data['todos'];
      return todosJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }
}
