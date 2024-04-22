import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/onboarding/screens/onboarding_screen.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Sign up for EarnWise",
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
              hint: "First Name",
              // prefix: Icon(Icons.person),
            ),
            const YMargin(16),
            const AppTextField(
              hint: "Last Name",
              // prefix: Icon(Icons.person_outline),
            ),
            const YMargin(16),
            const AppTextField(
              hint: "Email Address",
              // prefix: Icon(Icons.email_outlined),
            ),
            const YMargin(16),
            const AppTextField(
              hint: "Password",
              obscureText: true,
              // prefix: Icon(Icons.lock_outline),
            ),
            const YMargin(40),
            AppButton(
              text: "SIGN UP",
              onPressed: () {
                push(const OnboardingScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}