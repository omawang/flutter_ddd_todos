import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_ddd_todos/domain/auth/entities/user.dart';
import 'package:flutter_ddd_todos/domain/core/value_objects/value_objects.dart';

extension FirebaseAuthUserX on firebase_auth.User {
  User toDomain() {
    return User(id: UniqueId.fromUniqueString(uid));
  }
}
