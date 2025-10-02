part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class LOadingPOstsState extends PostsState {}

class LoadedPOstState extends PostsState {
  final List<Post> posts;

  const LoadedPOstState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostState extends PostsState {
  final String message;

  const ErrorPostState({required this.message});
  @override
  List<Object> get props => [message];
}
