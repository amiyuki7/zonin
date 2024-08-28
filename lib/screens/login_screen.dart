import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonin/colors.dart';
import 'package:zonin/components/oauth_button.dart';
import 'package:zonin/components/zonin_text_field.dart';
import 'package:zonin/screens/sign_up_screen.dart';
import 'package:zonin/state/auth/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;
  IconData _obscureIcon = CupertinoIcons.eye;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        setState(() {
          _isLoading = state is Loading;
        });
        if (state is Unauthenticated) {
          final snackBar = SnackBar(
            content: Text(
              state.reason,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: darkBg2),
            ),
            backgroundColor: const Color(0xFFFF7477),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is Authenticated) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      child: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Image
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.fill,
                scale: 2,
              ),
              const SizedBox(height: 10.0),
              // Logo Text
              const Text(
                'Zonin',
                style: TextStyle(
                  fontSize: 35,
                  color: accentBlue2,
                  fontFamily: 'Caros Soft',
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ZoninTextField(
                        controller: emailController,
                        labelText: 'EMAIL',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Icon(CupertinoIcons.mail_solid, size: 24),
                        validator: (value) {
                          if (value!.isEmpty) return 'Please fill in this field';
                        },
                      ),
                      const SizedBox(height: 5),
                      ZoninTextField(
                          controller: passwordController,
                          labelText: 'PASSWORD',
                          obscureText: _obscurePassword,
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                                _obscureIcon = _obscurePassword
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash;
                              });
                            },
                            icon: Icon(_obscureIcon, size: 24),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Please fill in this field';
                          })
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 0),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: accentPurple,
                          fontSize: 16,
                          // TODO Remove this when it's time to add a forgot email/password service
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 5,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 53, minWidth: 53),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context
                                .read<AuthCubit>()
                                .signIn(emailController.text, passwordController.text);
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStatePropertyAll<Size>(
                              Size(MediaQuery.of(context).size.width * 0.8, 0)),
                          backgroundColor: const MaterialStatePropertyAll<Color>(accentPurple),
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 15)),
                          splashFactory: InkSplash.splashFactory,
                          overlayColor: const MaterialStatePropertyAll<Color>(accentPurple2),
                        ),
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Color(0xFF21005D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 25),
              const Text(
                "or continue with (not available)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OAuthButton(logoName: 'google', bgColour: Colors.white),
                  SizedBox(width: 15),
                  OAuthButton(logoName: 'fb', bgColour: Color(0xFF395692)),
                  SizedBox(width: 15),
                  OAuthButton(logoName: 'twitter', bgColour: Colors.white),
                  SizedBox(width: 15),
                  OAuthButton(logoName: 'gh', bgColour: Colors.white),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AuthCubit>(context),
                            child: const SignUpScreen(),
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    child: const Text("Sign Up",
                        style: TextStyle(
                          color: accentPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
