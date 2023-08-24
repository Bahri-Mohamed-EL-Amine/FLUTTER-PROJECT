import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts_usecase.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  GetAllPostsUsecase getAllPostsUsecase;
  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is PostsGetEvent || event is PostsRefreshEvent) {
        emit(PostsLoading());
        final failureOrPosts = await getAllPostsUsecase();
        failureOrPosts.fold((failure) {
          emit(PostsError(message: mapFailureToMessage(failure)));
        }, (posts) {
          emit(PostsLoaded(posts: posts));
        });
      }
    });
  }
}
