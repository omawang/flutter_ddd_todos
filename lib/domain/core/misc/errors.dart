import 'package:flutter_ddd_todos/domain/core/value_objects/failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation = 'Encountered a ValueFailure at an unrecoverable point';
    return Error.safeToString('$explanation. Failure was: $valueFailure');
  }
}
