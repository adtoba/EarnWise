import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/auth/screens/forgot_password_screen.dart';
import 'package:earnwise/src/features/auth/screens/register_screen.dart';
import 'package:earnwise/src/features/auth/view_model/auth_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = ref.watch(authViewModel);

    return LoadingOverlay(
      isLoading: authProvider.isLoading,
      child: Scaffold(
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(30),
                AppTextField(
                  controller: emailController,
                  hint: "Email Address",
                  validator: Validators.validateEmail,
                ),
                const YMargin(16),
                AppTextField(
                  controller: passwordController,
                  hint: "Password",
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const YMargin(10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      push(const ForgotPasswordScreen());
                    }, 
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
                  text: "Log In",
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      authProvider.login({
                        "email": emailController.text,
                        "password": passwordController.text
                      });
                    }
                  },
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
        ),
      ),
    );
  }
}