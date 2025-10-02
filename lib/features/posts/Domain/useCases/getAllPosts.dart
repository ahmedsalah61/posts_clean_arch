import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitiy/post.dart';
import '../repo/postRepo.dart';


class Getallposts {
  final Postrepo repository;

  Getallposts(this.repository);
  Future<Either<Failures, List<Post>>> call() async {
    return await repository.GetAllPosts();
  }
}
