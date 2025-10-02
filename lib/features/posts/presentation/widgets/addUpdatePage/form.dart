import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/entitiy/post.dart';
import '../../bloc/addORdeletOrup/add_update_delete_posts_bloc.dart';
import 'form_submit_btn.dart';
import 'textFormFeild.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Textformfeild(
            controller: _titleController,
            multiLines: false,
            name: "Title",
          ),
          Textformfeild(
            controller: _bodyController,
            multiLines: true,
            name: "body",
          ),
          FormSubmitBtn(
            onPressed: validateFormThenUpdateOrAddPost,
            isUpdatePost: widget.isUpdatePost,
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<AddUpdateDeletePostsBloc>(
          context,
        ).add(UpdatePostEvent(posts: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostsBloc>(
          context,
        ).add(AddPostEvent(posts: post));
      }
    }
  }
}
