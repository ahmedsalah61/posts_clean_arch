import 'package:flutter/material.dart';

import '../../../Domain/entitiy/post.dart';
import 'delete_btn_widget.dart';
import 'update_btn_widget.dart';

class DatailWidget extends StatelessWidget {
  final Post post;
  const DatailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(height: 50),
          Text(post.body, style: TextStyle(fontSize: 20)),
          Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdateBtnWidget(post: post),
              DeleteBtnWidget(postId: post.id!),
            ],
          ),
        ],
      ),
    );
  }
}
