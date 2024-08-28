part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Loading extends AuthState {}

final class Unauthenticated extends AuthState {
  final String reason;

  /// This is just to enable for distinct states to be registered  upon `emit()` when resubmitting
  /// failed login attempts
  final DateTime _id;

  const Unauthenticated(this.reason, this._id);

  @override
  List<Object> get props => [reason, _id];
}

final class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}
