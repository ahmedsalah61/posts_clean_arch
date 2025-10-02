import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entitiy/post.dart';

abstract class Postrepo {
  Future<Either<Failures, List<Post>>> GetAllPosts();
  Future<Either<Failures, Unit>> DeletePost(int id);
  Future<Either<Failures, Unit>> updatePost(Post post);
  Future<Either<Failures, Unit>> addPost(Post post);
}
