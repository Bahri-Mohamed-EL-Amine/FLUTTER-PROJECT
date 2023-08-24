import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';

class AddPostUsecase {
  PostsRepository repository;
  AddPostUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
