part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostsGetEvent extends PostsEvent {}

class PostsRefreshEvent extends PostsEvent {}
