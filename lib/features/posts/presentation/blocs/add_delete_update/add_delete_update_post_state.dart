part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class AddDeleteUpdatePostLoading extends AddDeleteUpdatePostState {}

class AddDeleteUpdatePostSuccess extends AddDeleteUpdatePostState {
  final String message;
  const AddDeleteUpdatePostSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class AddDeleteUpdatePostFailure extends AddDeleteUpdatePostState {
  final String message;
  const AddDeleteUpdatePostFailure({required this.message});
  @override
  List<Object> get props => [message];
}
