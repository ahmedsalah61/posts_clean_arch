import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/snackBar_message.dart';
import '../../../../../core/widget/loading_widget.dart';
import '../../bloc/addORdeletOrup/add_update_delete_posts_bloc.dart';
import '../../pages/postPage.dart';
import 'delete_post_widget.dart';

class DeleteBtnWidget extends StatelessWidget {
  final int postId;
  const DeleteBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                ),
                onPressed: () => _deleteDialog(context, postId)
                  
                ,
                icon: Icon(Icons.delete_outline),
                label: Text("delete"),
              );
  }
  void _deleteDialog(BuildContext context , int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<
          AddUpdateDeletePostsBloc,
          AddUpdateDeletePostsState
        >(
          listener: (context, state) {
            if (state is trueMessageState) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Postpage()),
                (route) => false,
              );
            } else if (state is ErrorState) {
              Navigator.of(context).pop();
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddOrDeleteState) {
              return AlertDialog(title: LoadingWidget());
            }
            return DeletePostWidget(postId: postId);
          },
        );
      },
    );
  }
}