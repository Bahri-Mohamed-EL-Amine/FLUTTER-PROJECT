import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/blocs/add_delete_update/add_delete_update_post_bloc.dart';

import '../../domain/entities/post.dart';

class AddUpdatePostView extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  AddUpdatePostView({super.key, this.post, required this.isUpdate});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, formKey),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(isUpdate ? 'Update Post' : 'Add Post'),
    );
  }

  _buildBody(BuildContext context, GlobalKey<FormState> formKey) {
    if (post != null) {
      _titleController.text = post!.title;
      _bodyController.text = post!.body;
    }
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _titleController,
                validator: (value) =>
                    value!.isEmpty ? "Title can not be empty" : null,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                child: TextFormField(
                  controller: _bodyController,
                  validator: (value) =>
                      value!.isEmpty ? "Body cannot be empty" : null,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Body',
                  ),
                ),
              ),
            ),
            BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
              listener: (context, state) {
                if (state is AddDeleteUpdatePostFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.message),
                    ),
                  );
                } else if (state is AddDeleteUpdatePostSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) => state is AddDeleteUpdatePostLoading
                  ? const LoadingWidget()
                  : ElevatedButton(
                      onPressed: () {
                        if (isUpdate) {
                          BlocProvider.of<AddDeleteUpdatePostBloc>(context)
                              .add(PostUpdateEvent(post: post!));
                        } else {
                          final post = Post(
                            id: 1000,
                            userId: 1000,
                            title: _titleController.text,
                            body: _bodyController.text,
                          );
                          BlocProvider.of<AddDeleteUpdatePostBloc>(context)
                              .add(PostAddEvent(post: post));
                        }
                      },
                      child: Text(isUpdate ? 'Update' : 'Add'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
