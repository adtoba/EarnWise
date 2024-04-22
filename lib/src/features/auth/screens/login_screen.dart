import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/auth/screens/register_screen.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Sign in to your account",
          style: TextSizes.s22.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: config.sw(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(30),
            const AppTextField(
              hint: "Email Address",
              // prefix: Icon(Icons.email),
            ),
            const YMargin(16),
            const AppTextField(
              hint: "Password",
              // prefix: Icon(Icons.lock),
              obscureText: true,
            ),
            const YMargin(10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, 
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                ),
                child: const Text(
                  "Forgot Password?"
                )
              ),
            ),
            const YMargin(20),
            AppButton(
              text: "LOG IN",
              onPressed: () {},
            ),
            const YMargin(20),
            Center(
              child: TextButton(
                onPressed: () {
                  push(const RegisterScreen());
                }, 
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                ),
                child: const Text(
                  "Don't have an account? Register"
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}