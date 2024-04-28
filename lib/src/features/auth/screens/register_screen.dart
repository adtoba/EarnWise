import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/auth/view_model/auth_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
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
            "Join EarnWise now - it's free",
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
                  controller: fullNameController,
                  hint: "Full Name",
                  validator: Validators.validateField,
                  // prefix: Icon(Icons.person),
                ),
                const YMargin(16),
                AppTextField(
                  controller: emailController,
                  hint: "Email Address",
                  validator: Validators.validateEmail,
                  // prefix: Icon(Icons.email_outlined),
                ),
                const YMargin(16),
                AppTextField(
                  controller: passwordController,
                  hint: "Password",
                  obscureText: true,
                  validator: Validators.validatePassword,
                  // prefix: Icon(Icons.lock_outline),
                ),
                const YMargin(40),
                AppButton(
                  text: "Sign Up",
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      authProvider.register({
                        "fullName": fullNameController.text,
                        "email": emailController.text,
                        "password": passwordController.text
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}