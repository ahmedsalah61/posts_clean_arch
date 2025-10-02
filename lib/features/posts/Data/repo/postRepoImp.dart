import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/networkInfo.dart';
import '../../Domain/entitiy/post.dart';
import '../../Domain/repo/postRepo.dart';
import '../dataSource/local_data.dart';
import '../dataSource/remote_data.dart';
import '../model/postModel.dart';

typedef DeleteORupdateORadd = Future<Unit> Function();

class Postrepoimp implements Postrepo {
  final RemoteData remoteData;
  final LocalData localData;
  final Networkinfo networkinfo;

  Postrepoimp({
    required this.networkinfo,
    required this.remoteData,
    required this.localData,
  });
  @override
  Future<Either<Failures, List<Post>>> GetAllPosts() async {
    if (await networkinfo.isConnected) {
      try {
        final remotePosts = await remoteData.GetAllPosts();
        localData.cashPosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localData.getCashedData();
        return right(localPosts);
      } on EmptyCashExcption {
        return left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failures, Unit>> addPost(Post post) async {
    final Postmodel postmodel = Postmodel(title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteData.addPost(postmodel);
    });
  }

  @override
  Future<Either<Failures, Unit>> DeletePost(int id) async {
    return await _getMessage(() {
      return remoteData.DeletePost(id);
    });
  }

  @override
  Future<Either<Failures, Unit>> updatePost(Post post) async {
    final Postmodel postmodel = Postmodel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteData.updatePost(postmodel);
    });
  }

  Future<Either<Failures, Unit>> _getMessage(
    DeleteORupdateORadd deleteORupdateORadd,
  ) async {
    if (await networkinfo.isConnected) {
      try {
        await deleteORupdateORadd();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
