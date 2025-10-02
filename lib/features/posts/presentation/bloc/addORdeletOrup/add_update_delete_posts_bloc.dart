import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../Domain/entitiy/post.dart';
import '../../../Domain/useCases/addPost.dart';
import '../../../Domain/useCases/deletePost.dart';
import '../../../Domain/useCases/updatePost.dart';


part 'add_update_delete_posts_event.dart';
part 'add_update_delete_posts_state.dart';

class AddUpdateDeletePostsBloc
    extends Bloc<AddUpdateDeletePostsEvent, AddUpdateDeletePostsState> {
  final AddpostUSeCase addPost;
  final DeletepostUseCase deletePost;
  final UpdatepostUseCase updatePost;
  AddUpdateDeletePostsBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddUpdateDeletePostsInitial()) {
    on<AddUpdateDeletePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddOrDeleteState());
        final FailureOrDoneMessage = await addPost(event.posts);
        emit(
          _eitherDoneMessageOrErrorState(
            FailureOrDoneMessage,
            ADD_SUCCESS_MESSAGE,
          ),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddOrDeleteState());
        final FailureOrDoneMessage = await updatePost(event.posts);
        emit(
          _eitherDoneMessageOrErrorState(
            FailureOrDoneMessage,
            UPDATE_SUCCESS_MESSAGE,
          ),
        );
      } else if (event is DeletePostsEvent) {
        emit(LoadingAddOrDeleteState());
        final FailureOrDoneMessage = await deletePost(event.postId);
        emit(
          _eitherDoneMessageOrErrorState(
            FailureOrDoneMessage,
            DELETE_SUCCESS_MESSAGE,
          ),
        );
      }
    });
  }
  AddUpdateDeletePostsState _eitherDoneMessageOrErrorState(
    Either<Failures, Unit> either,
    String message,
  ) {
    return either.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (_) => trueMessageState(message: message),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCashFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
