import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/strings/failures.dart';
import '../../../../Domain/entitiy/post.dart';
import '../../../../Domain/useCases/getAllPosts.dart';


part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final Getallposts getallposts;
  PostsBloc({ required this.getallposts,  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LOadingPOstsState());
        final failureOrPosts = await getallposts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPOstEvent) {
        emit(LOadingPOstsState());
        final failureOrPOsts = await getallposts();
        emit(_mapFailureOrPostsToState(failureOrPOsts));
      }
    });
  }
  PostsState _mapFailureOrPostsToState(Either<Failures, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPOstState(posts: posts),
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
