import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp_clean/core/app_theme.dart';

import 'package:postsapp_clean/features/posts/presentation/bloc/addORdeletOrup/add_update_delete_posts_bloc.dart';
import 'package:postsapp_clean/features/posts/presentation/bloc/posts/bloc/posts_bloc.dart';
import 'package:postsapp_clean/features/posts/presentation/pages/postPage.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
      BlocProvider(create: (_) => di.sl<AddUpdateDeletePostsBloc>()),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: Postpage()
      ),
    );
  }
}
