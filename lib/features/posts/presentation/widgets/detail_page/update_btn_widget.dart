import 'package:flutter/material.dart';
import '../../../Domain/entitiy/post.dart';
import '../../pages/add_ubdate_post.dart';

class UpdateBtnWidget extends StatelessWidget {
  final Post post;
  const UpdateBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PostAddUpdatePage(isUpdatePost: true, post: post),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
                label: Text("Edit"),
              );
  }
}