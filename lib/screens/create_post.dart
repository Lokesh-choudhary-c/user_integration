import 'package:flutter/material.dart';
import 'package:users_bloc_api/models/post_model.dart';


class CreatePostScreen extends StatefulWidget {
  final int userId;

  const CreatePostScreen({super.key, required this.userId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: widget.userId,
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
      );
      Navigator.pop(context, newPost);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Create Post'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) => value!.isEmpty ? 'Please enter title' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bodyController,
                      decoration: const InputDecoration(labelText: 'Body'),
                      maxLines: 5,
                      validator: (value) => value!.isEmpty ? 'Please enter body' : null,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Post'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}