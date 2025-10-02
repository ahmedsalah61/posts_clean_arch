import 'package:dartz/dartz.dart';

import 'package:postsapp_clean/core/error/failures.dart';
import 'package:postsapp_clean/features/posts/Domain/entitiy/post.dart';
import 'package:postsapp_clean/features/posts/Domain/repo/postRepo.dart';


class UpdatepostUseCase {
  final Postrepo repository;

  UpdatepostUseCase(this.repository);
  Future<Either<Failures, Unit>> call(Post PostNew) async {
    return await repository.updatePost(PostNew);
  }
}
