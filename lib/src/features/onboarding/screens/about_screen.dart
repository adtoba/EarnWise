import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/onboarding/view_model/onboarding_provider.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutUserScreen extends ConsumerStatefulWidget {
  const AboutUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutUserScreenState();
}

class _AboutUserScreenState extends ConsumerState<AboutUserScreen> {

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final timezoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);
    var onboardingState = ref.watch(onboardingProvider);

    return Container(
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
              controller: titleController,
              hint: "Professional Title",
              validator: Validators.validateField,
              onChanged: (val) {
                profileProvider.professionalTitle = val;
              },
            ),
            const YMargin(16),
            AppTextField(
              controller: bioController,
              hint: "Short Bio",
              maxLines: 4,
              validator: Validators.validateField,
              onChanged: (val) {
                profileProvider.bio = val;
              },
            ),
            const YMargin(16),
            AppTextField(
              controller: phoneController,
              hint: "Phone Number",
              validator: Validators.validatePhone,
              onChanged: (val) {
                profileProvider.phone = val;
              },
            ),
            const YMargin(16),
            AppTextField(
              controller: locationController,
              hint: "Your Location",
              validator: Validators.validateField,
              onChanged: (val) {
                profileProvider.location = val;
              },
            ),
            const YMargin(16),
            AppTextField(
              controller: timezoneController,
              hint: "Timezone",
              validator: Validators.validateField,
              onChanged: (val) {
                profileProvider.timezone = val;
              },
            ),
            const YMargin(40),
            AppButton(
              text: "Continue",
              onPressed: () {
                if(formKey.currentState!.validate()) {
                  onboardingState.onPageChanged(1);
                }
                
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
      ),
    );
  }
}