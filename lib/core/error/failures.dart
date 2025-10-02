import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

class OfflineFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class EmptyCashFailure extends Failures {
  @override
  List<Object?> get props => [];
}
