import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import 'package:zonin/screens/login_screen.dart';
import 'package:zonin/state/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompositionRoot {
  static late RethinkDb _r;
  static late Connection _conn;
  static late IUserService _userService;
  static late AuthCubit authCubit;

  static Future<void> configure() async {
    _r = RethinkDb();
    _conn = await _r.connect(host: '127.0.0.1', port: 28015);
    _userService = UserService(_r, _conn);
    authCubit = AuthCubit(_userService);
  }

  static Widget composeLoginUI() {
    //   return BlocProvider<AuthCubit>(
    //     create: (BuildContext context) => authCubit,
    //     child: LoginScreen(),
    //   );
    // }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => authCubit),
      ],
      child: const LoginScreen(),
    );
  }
}
