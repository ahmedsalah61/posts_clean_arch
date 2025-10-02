part of 'add_update_delete_posts_bloc.dart';

sealed class AddUpdateDeletePostsState extends Equatable {
  const AddUpdateDeletePostsState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostsInitial extends AddUpdateDeletePostsState {}

class LoadingAddOrDeleteState extends AddUpdateDeletePostsState {}

class ErrorState extends AddUpdateDeletePostsState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class trueMessageState extends AddUpdateDeletePostsState {
  final String message;

  const trueMessageState({required this.message});
  @override
  List<Object> get props => [message];
}
