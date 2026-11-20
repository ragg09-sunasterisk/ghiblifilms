// a failure is what the ViewModel see, it carries the message the View can show directly

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure() : super('The server had a problem. Please try again');
}

class NetworkFailure extends Failure {
  const NetworkFailure()
    : super('No internet connection. Check your network and retry');
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('Something went wrong. Please try again.');
}
