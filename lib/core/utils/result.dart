import 'package:ghiblifilms/core/error/failures.dart';

/// Either a success holding data, or a failure holding a [Failure].
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failed<T> extends Result<T> {
  final Failure failure;
  const Failed(this.failure);
}
