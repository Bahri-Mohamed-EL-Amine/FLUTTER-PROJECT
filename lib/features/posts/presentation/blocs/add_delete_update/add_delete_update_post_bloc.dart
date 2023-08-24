import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts_app/core/constants/strings.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/failures.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/update_post_usecase.dart';

import '../../../domain/entities/post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  AddPostUsecase addPostUsecase;
  DeletePostUsecase deletePostUsecase;
  UpdatePostUsecase updatePostUsecase;
  AddDeleteUpdatePostBloc({
    required this.addPostUsecase,
    required this.deletePostUsecase,
    required this.updatePostUsecase,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is PostAddEvent) {
        emit(AddDeleteUpdatePostLoading());
        final failureOrUnit = await addPostUsecase(event.post);

        emit(_eitherSuccessOrFailureState(
            failureOrUnit, AppSuccesStrings.addSuccesMessage));
      } else if (event is PostDeleteEvent) {
        emit(AddDeleteUpdatePostLoading());
        final failureOrUnit = await deletePostUsecase(event.id);

        emit(_eitherSuccessOrFailureState(
            failureOrUnit, AppSuccesStrings.deleteSuccesMessage));
      } else if (event is PostUpdateEvent) {
        emit(AddDeleteUpdatePostLoading());
        final failureOrUnit = await updatePostUsecase(event.post);
        emit(_eitherSuccessOrFailureState(
            failureOrUnit, AppSuccesStrings.updateSuccesMessage));
      }
    });
  }

  AddDeleteUpdatePostState _eitherSuccessOrFailureState(
      Either<Failure, Unit> either, String message) {
    return either.fold((failure) {
      return AddDeleteUpdatePostFailure(message: mapFailureToMessage(failure));
    }, (_) {
      return AddDeleteUpdatePostSuccess(message: message);
    });
  }
}
