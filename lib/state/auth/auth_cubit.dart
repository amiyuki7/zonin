import 'package:backend/backend.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IUserService _userService;

  AuthCubit(this._userService) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _userService.login(email, password);
    if (result.error != null) {
      // We have an invalid email/password
      emit(Unauthenticated(result.error!, DateTime.now()));
      return;
    }
    emit(Authenticated(result.value!));
  }

  Future<void> signUp(String email, String password) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _userService.create(email, password);
    if (result.error != null) {
      // The email already exists
      emit(Unauthenticated(result.error!, DateTime.now()));
      return;
    }
    emit(Authenticated(result.value!));
  }

  void signOut() {
    emit(AuthInitial());
  }
}
