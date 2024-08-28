import 'package:backend/models/user.dart';

abstract class IUserService {
  /// Attempts to login.
  /// [password] is _**unhashed**_.
  /// Returns a `User` instance with a populated `_id` field if the login is successful.
  Future<UserResult<User, String>> login(String email, String password);

  /// [password] is _**unhashed**_.
  /// Returns a `User` instance with a populated `_id` field if user creation is successful.
  Future<UserResult<User, String>> create(String email, String password);
}

/// An abstraction over error handling, avoiding the throw/catch pattern. Inspired by Rust's
/// `Result<T, E>` enum type.
final class UserResult<T, E> {
  T? value;
  E? error;

  UserResult.ok(T this.value);
  UserResult.err(E this.error);
}
