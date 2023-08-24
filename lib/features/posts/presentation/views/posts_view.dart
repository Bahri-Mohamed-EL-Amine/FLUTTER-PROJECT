import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/routes/app_routes.dart';
import 'package:flutter_clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/blocs/posts/posts_bloc.dart';

import '../widgets/posts_list_widget.dart';
import '../widgets/posts_message_widget.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Posts"),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: ((context, state) {
        if (state is PostsLoading) {
          return const LoadingWidget();
        } else if (state is PostsLoaded) {
          return PostsListWidget(posts: state.posts);
        } else if (state is PostsError) {
          return PostsMessageWidget(message: state.message);
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.addUpdatePostRoute,
            arguments: {'isUpdate': false, 'post': null});
      },
      child: const Icon(Icons.add),
    );
  }
}
