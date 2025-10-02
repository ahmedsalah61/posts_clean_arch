import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/loading_widget.dart';
import '../bloc/posts/bloc/posts_bloc.dart';
import 'add_ubdate_post.dart';
import '../widgets/post_page.dart/message_display.dart';
import '../widgets/post_page.dart/post_list.dart';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppar(),
      body: _buildBody(),
      floatingActionButton: _floatingactionbutn(),
    );
  }

  AppBar _buildAppar() => AppBar(
    title: Text("posts ", style: TextStyle(color: Colors.white)),
  );

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LOadingPOstsState) {
            return LoadingWidget();
          } else if (state is LoadedPOstState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),

              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorPostState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPOstEvent());
  }

  Widget _floatingactionbutn() {
    return FloatingActionButton(onPressed: () {
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PostAddUpdatePage(
                      isUpdatePost: false,
                    )));
    }, child: Icon(Icons.add));
  }
}
