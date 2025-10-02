import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitiy/post.dart';
import '../repo/postRepo.dart';


class AddpostUSeCase {
  final Postrepo repository;

  AddpostUSeCase(this.repository);
  Future<Either<Failures, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
