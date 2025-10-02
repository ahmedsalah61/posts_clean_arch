import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/addORdeletOrup/add_update_delete_posts_bloc.dart';

class DeletePostWidget extends StatelessWidget {
  final int postId;
  const DeletePostWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure ?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        },
         child: Text("No")),
         TextButton(onPressed: (){
          BlocProvider.of<AddUpdateDeletePostsBloc>(context).add(DeletePostsEvent(postId: postId));
         }, child: Text("yes"))
      ],
    );
  }
}