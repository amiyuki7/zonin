import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zonin/colors.dart';
import 'package:zonin/components/zonin_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool _obscurePassword = true;
  IconData _obscureIcon = CupertinoIcons.eye;
  bool _obscureConfirm = true;
  IconData _obscureConfirmIcon = CupertinoIcons.eye;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35,
                  color: accentPurple,
                  fontFamily: 'Caros Soft',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter your details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ZoninTextField(
                controller: emailController,
                labelText: 'EMAIL',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(CupertinoIcons.mail_solid, size: 24),
                validator: (value) {
                  if (value!.isEmpty) return 'Please fill in this field';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) return 'Please fill in this field';
                  if (value.length < 8) return 'Password must be at least 8 characters long';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ZoninTextField(
                controller: confirmController,
                labelText: 'CONFIRM PASSWORD',
                obscureText: _obscureConfirm,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirm = !_obscureConfirm;
                      _obscureConfirmIcon =
                          _obscureConfirm ? CupertinoIcons.eye : CupertinoIcons.eye_slash;
                    });
                  },
                  icon: Icon(_obscureConfirmIcon, size: 24),
                ),
                validator: (value) {
                  if (value != passwordController.text) return 'Passwords do not match!';
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: TextButton(
                  onPressed: () {
                    print(_formKey.currentState!.validate());
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(accentPurple),
                    padding: MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.only(left: 135, right: 135, top: 15, bottom: 15),
                    ),
                    splashFactory: InkSplash.splashFactory,
                    overlayColor: MaterialStatePropertyAll<Color>(accentPurple2),
                  ),
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Color(0xFF21005D),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
