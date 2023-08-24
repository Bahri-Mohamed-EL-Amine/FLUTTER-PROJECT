import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/failures.dart';
import 'package:flutter_clean_architecture_posts_app/core/network/network_info.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../datasources/local/local_data_source.dart';
import '../datasources/remote/remote_data_source.dart';

typedef AddUpdateOrDeletePost = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final LocalDataSourceImpl localDataSource;
  final RemoteDataSourceImpl remoteDataSource;
  final NetworkInfoImpl networkInfoImpl;
  PostsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfoImpl,
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfoImpl.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cashePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCashedPosts();
        return Right(localPosts);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getAnswer(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getAnswer(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getAnswer(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getAnswer(
      AddUpdateOrDeletePost addUpdateOrDeletePost) async {
    if (await networkInfoImpl.isConnected) {
      try {
        await addUpdateOrDeletePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}
