import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/views/add_update_post_view.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/views/posts_view.dart';

class AppRoutes {
  static const homeRoute = '/';
  static const addUpdatePostRoute = '/addUpdatepost';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => const PostsView());
      case addUpdatePostRoute:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AddUpdatePostView(
            isUpdate: data['isUpdate'],
            post: data['post'],
          ),
        );
      default:
        return null;
    }
  }
}
