import 'package:flutter/material.dart';

import '../../Domain/entitiy/post.dart';
import '../widgets/detail_page/datail_widget.dart';

class DetailPage extends StatelessWidget {
  final Post posts;

  const DetailPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppar(),
      body: _bulidBody(),
    );
  }
  AppBar _buildAppar(){
    return AppBar(title: Text("detail page"),);
  }
  Widget _bulidBody(){
    return Center(
      child: Padding(padding: EdgeInsets.all(10),
      child: DatailWidget(post: posts,),),
    );
  }
}