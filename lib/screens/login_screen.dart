import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zonin/colors.dart';
import 'package:zonin/components/oauth_button.dart';
import 'package:zonin/components/zonin_text_field.dart';
import 'package:zonin/screens/sign_up_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  ZoninTextField(
                    controller: emailController,
                    labelText: 'EMAIL',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  ZoninTextField(
                    controller: passwordController,
                    labelText: 'PASSWORD',
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                          _obscureIcon =
                              _obscurePassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash;
                        });
                      },
                      icon: Icon(_obscureIcon, size: 24),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: accentPurple,
                      ),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(accentPurple),
                padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.only(left: 145, right: 145, top: 15, bottom: 15),
                ),
                splashFactory: InkSplash.splashFactory,
                overlayColor: MaterialStatePropertyAll<Color>(accentPurple2),
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
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
    );
  }
}
