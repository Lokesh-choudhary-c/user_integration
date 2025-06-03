class Todo {
  final int id;
  final int userId;
  final String todo;
  final bool completed;

  Todo({
    required this.id,
    required this.userId,
    required this.todo,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }
}
