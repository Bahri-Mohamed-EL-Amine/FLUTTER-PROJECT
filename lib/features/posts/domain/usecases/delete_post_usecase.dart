import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/errors/failures.dart';

class DeletePostUsecase {
  PostsRepository repository;
  DeletePostUsecase(this.repository);
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}
