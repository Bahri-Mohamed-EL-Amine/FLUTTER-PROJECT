part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();

  @override
  List<Object> get props => [];
}

class PostAddEvent extends AddDeleteUpdatePostEvent {
  final Post post;
  const PostAddEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class PostUpdateEvent extends AddDeleteUpdatePostEvent {
  final Post post;
  const PostUpdateEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class PostDeleteEvent extends AddDeleteUpdatePostEvent {
  final int id;
  const PostDeleteEvent({required this.id});
  @override
  List<Object> get props => [id];
}
