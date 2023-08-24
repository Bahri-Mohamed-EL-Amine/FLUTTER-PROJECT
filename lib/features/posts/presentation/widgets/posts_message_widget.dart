import 'package:flutter/material.dart';

class PostsMessageWidget extends StatelessWidget {
  final String message;
  const PostsMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
