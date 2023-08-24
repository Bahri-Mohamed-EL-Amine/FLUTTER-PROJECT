import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.addUpdatePostRoute,
              arguments: {'isUpdate': true, 'post': posts[index]},
            );
          },
          title: Text(posts[index].title),
          subtitle: Text(posts[index].body),
          leading: Text(posts[index].id.toString()),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
