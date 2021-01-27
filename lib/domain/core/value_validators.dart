import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
    String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  }
  return left(
    ValueFailure.exceedingLength(failedValue: input, max: maxLength),
  );
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  }
  return right(input);
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  }
  return right(input);
}

Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
    KtList<T> input, int maxLength) {
  if (input.size <= maxLength) {
    return right(input);
  }
  return left(ValueFailure.listTooLong(failedValue: input, max: maxLength));
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  }
  return left(ValueFailure.invalidEmail(failedValue: input));
}

Either<ValueFailure<String>, String> validateShortPassword(String input) {
  if (input.length >= 6) {
    return right(input);
  }
  return left(ValueFailure.shortPassword(failedValue: input));
}
