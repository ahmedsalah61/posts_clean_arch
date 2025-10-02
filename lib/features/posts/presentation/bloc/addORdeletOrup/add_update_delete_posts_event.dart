part of 'add_update_delete_posts_bloc.dart';

sealed class AddUpdateDeletePostsEvent extends Equatable {
  const AddUpdateDeletePostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostsEvent {
  final Post posts;

  const AddPostEvent({required this.posts});
  @override
  List<Object> get props => [posts];
}

class UpdatePostEvent extends AddUpdateDeletePostsEvent {
  final Post posts;

  const UpdatePostEvent({required this.posts});
  @override
  List<Object> get props => [posts];
}

class DeletePostsEvent extends AddUpdateDeletePostsEvent {
  final int postId;

  const DeletePostsEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
