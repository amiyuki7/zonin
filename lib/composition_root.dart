import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import 'package:zonin/screens/login_screen.dart';
import 'package:zonin/screens/main_screen.dart';
import 'package:zonin/state/activity/activity_bloc.dart';
import 'package:zonin/state/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonin/theme.dart';

class CompositionRoot {
  static late RethinkDb _r;
  static late Connection _conn;
  static late IUserService _userService;
  static late IActivityService _activityService;
  // static late AuthCubit authCubit;

  static Future<void> configure() async {
    _r = RethinkDb();
    _conn = await _r.connect(host: '127.0.0.1', port: 28015);
    _userService = UserService(_r, _conn);
    _activityService = ActivityService(_r, _conn);
    // authCubit = AuthCubit(_userService);
  }

  static Widget composeLoginUI(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (BuildContext context) => authCubit),
    //   ],
    //   child: const LoginScreen(),
    // );
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const LoginScreen(),
        ),
      ),
    );
  }
}

class Composer extends StatelessWidget {
  const Composer({super.key});

  @override
  Widget build(BuildContext context) {
    // Not allow landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return RepositoryProvider<AuthCubit>(
      create: (context) => AuthCubit(CompositionRoot._userService),
      child: MaterialApp(
        title: 'Zonin',
        debugShowCheckedModeBanner: false,
        theme: darkTheme(context),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return (state is Authenticated)
                ? MultiBlocProvider(
                    providers: [
                      BlocProvider<ActivityBloc>(
                        create: (context) =>
                            ActivityBloc(CompositionRoot._activityService, state.user.id!),
                      ),
                    ],
                    child: MainScreen(state.user),
                  )
                // MainScreen(state.user)
                : CompositionRoot.composeLoginUI(context);
          },
        ),
      ),
    );
  }
}
