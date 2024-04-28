import 'package:earnwise/src/features/onboarding/screens/about_screen.dart';
import 'package:earnwise/src/features/onboarding/screens/interests_screen.dart';
import 'package:earnwise/src/features/onboarding/view_model/onboarding_provider.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {

  int currentIndex = 0;

  PageController pageController = PageController(
    keepPage: true,
    initialPage: 0
  );

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  double progress = 0.5;

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    var onboardingState = ref.watch(onboardingProvider);

    return LoadingOverlay(
      isLoading: ref.watch(profileViewModel).isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if(onboardingState.currentIndex == 1) {
                onboardingState.onPageChanged(0);
              }
            }, 
            icon: const Icon(Icons.arrow_back_ios),
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          automaticallyImplyLeading: true,
          centerTitle: false,
          elevation: 0,
          title: Text(
            onboardingState.currentIndex == 0 
              ? "Tell us about yourself"
              : "Select your interests",
            style: TextSizes.s22.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 20), 
            child: LinearProgressIndicator(
              value: onboardingState.progress,
              valueColor: const AlwaysStoppedAnimation(Colors.orange),
            )
          ),
        ),
        body: PageView(
          controller: onboardingState.controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onboardingState.onPageChanged,
          children: const [
            AboutUserScreen(),
            InterestScreen()
          ],
        )
      ),
    );
  }
}