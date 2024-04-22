import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/onboarding/view_model/onboarding_provider.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutUserScreen extends ConsumerStatefulWidget {
  const AboutUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutUserScreenState();
}

class _AboutUserScreenState extends ConsumerState<AboutUserScreen> {

  @override
  Widget build(BuildContext context) {
    var onboardingState = ref.watch(onboardingProvider);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: config.sw(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YMargin(30),
          const AppTextField(
            hint: "Short Bio",
          ),
          const YMargin(16),
          const AppTextField(
            hint: "Phone Number",
          ),
          const YMargin(16),
          const AppTextField(
            hint: "Your Location",
          ),
          const YMargin(16),
          const AppTextField(
            hint: "Timezone",
            obscureText: true,
          ),
          const YMargin(40),
          AppButton(
            text: "Continue",
            onPressed: () {
              onboardingState.onPageChanged(1);
            },
          ),
          const YMargin(10),
          Center(
            child: TextButton(
              onPressed: () {
      
              }, 
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent)
              ),
              child: Text(
                "Skip",
                style: TextSizes.s16,
              )
            ),
          ),
        ],
      ),
    );
  }
}