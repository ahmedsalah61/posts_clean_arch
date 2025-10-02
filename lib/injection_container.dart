import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/networkInfo.dart';
import 'features/posts/Data/dataSource/local_data.dart';
import 'features/posts/Data/dataSource/remote_data.dart';
import 'features/posts/Data/repo/postRepoImp.dart';
import 'features/posts/Domain/repo/postRepo.dart';
import 'features/posts/Domain/useCases/addPost.dart';
import 'features/posts/Domain/useCases/deletePost.dart';
import 'features/posts/Domain/useCases/getAllPosts.dart';
import 'features/posts/Domain/useCases/updatePost.dart';
import 'features/posts/presentation/bloc/addORdeletOrup/add_update_delete_posts_bloc.dart';
import 'features/posts/presentation/bloc/posts/bloc/posts_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {

  //! feature post
  // bloc
  sl.registerFactory(() => PostsBloc(getallposts: sl()));
  sl.registerFactory(
    () => AddUpdateDeletePostsBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  // useCase
  sl.registerLazySingleton(() => Getallposts(sl()));
  sl.registerLazySingleton(() => AddpostUSeCase(sl()));
  sl.registerLazySingleton(() => DeletepostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatepostUseCase(sl()));

  // repository
  sl.registerLazySingleton<Postrepo>(
    () => Postrepoimp(networkinfo: sl(), remoteData: sl(), localData: sl()),
  );

  //dataSource
  sl.registerLazySingleton<RemoteData>(() => RemoteDataImplemnet(client: sl()));
  sl.registerLazySingleton<LocalData>(
    () => LocalDataImplement(sharedPreferences: sl()),
  );

  //!core
  sl.registerLazySingleton<Networkinfo>(() => NetworkinfoImpl(sl()));

  //!External
  final sharedPrefernces = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefernces);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
