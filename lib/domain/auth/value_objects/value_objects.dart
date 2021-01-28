import 'package:dartz/dartz.dart';
import 'package:flutter_ddd_todos/domain/core/value_objects/failures.dart';
import 'package:flutter_ddd_todos/domain/core/value_objects/value_objects.dart';
import 'package:flutter_ddd_todos/domain/core/misc/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(validateShortPassword(input));
  }

  const Password._(this.value);
}
