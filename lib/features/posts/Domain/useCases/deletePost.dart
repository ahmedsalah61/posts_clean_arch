import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repo/postRepo.dart';

class DeletepostUseCase {
  final Postrepo repository;

  DeletepostUseCase(this.repository);
  Future<Either<Failures, Unit>> call(int postID) async {
    return await repository.DeletePost(postID);
  }
}
