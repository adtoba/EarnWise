import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/onboarding/view_model/onboarding_provider.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestScreen extends ConsumerStatefulWidget {
  const InterestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InterestScreenState();
}

class _InterestScreenState extends ConsumerState<InterestScreen> {

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    var onboardingState = ref.watch(onboardingProvider);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: config.sw(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YMargin(30),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: onboardingState.categories.entries.map((e) {
              return InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  if(onboardingState.selectedInterests.contains(e.key)) {
                    onboardingState.removeInterest(e.key);
                  } else {
                    onboardingState.addInterest(e.key);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: onboardingState.selectedInterests.contains(e.key) ? Colors.orange : Colors.transparent,
                    border: Border.all(
                      color: isDarkMode ? Colors.white38 : Colors.grey
                    )
                  ),
                  child: Text(
                    e.key,
                    style: TextSizes.s12.copyWith(
                      color: onboardingState.selectedInterests.contains(e.key) ? Colors.black : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const YMargin(50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
            child: AppButton(
              text: "Proceed",
              onPressed: () {},
            ),
          ),
          const YMargin(10),
        ],
      ),
    );
  }
}