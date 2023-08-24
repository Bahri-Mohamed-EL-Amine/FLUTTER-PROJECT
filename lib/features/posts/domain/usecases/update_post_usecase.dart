import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/failures.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';

class UpdatePostUsecase {
  PostsRepository repository;
  UpdatePostUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
