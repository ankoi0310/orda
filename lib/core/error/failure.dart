abstract class Failure {
  Failure(this.message);

  final String message;
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}
