import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoInternetConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCasheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case NoInternetConnectionFailure:
      return "please check your internet connection";
    case ServerFailure:
      return "Internel server error.";
    case EmptyCasheFailure:
      return "No local data available.";
    default:
      return "Unexpected error try again.";
  }
}
