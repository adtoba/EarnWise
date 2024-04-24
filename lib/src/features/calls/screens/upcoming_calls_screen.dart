import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/calls/screens/request_calls_screen.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingScreen extends ConsumerStatefulWidget {
  const UpcomingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends ConsumerState<UpcomingScreen> {

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(height: 20),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(
              "assets/images/person.jpeg"
            )
          ),
          title: Text(
            "Call with Adebisi Sulaimon to talk about how to become a successful photographer",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextSizes.s14.copyWith(
              color: isDarkMode ? Colors.white : Colors.black
            ),
          ),
          subtitle: const Text(
            "In 30 mins"
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 20),
          onTap: () {
            showActiveCallInfoSheet();
          },
        );
      },
      itemCount: 2,
    );
  }

  showActiveCallInfoSheet() {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.5,
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(30),
              Row(
                children: [
                  Text(
                    "Schedule Info",
                    style: TextStyle(
                      fontSize: config.sp(22),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const XMargin(10),
                  const Icon(Icons.info_outline),
                ],
              ),
              const YMargin(20),
              Text(
                "Adebisi Sulaimon wants to talk to you about content creation and how to become an expert in the field",
                style: TextSizes.s16.copyWith(
                  fontWeight: FontWeight.normal,
                  color: isDarkMode ? Colors.white : Colors.black
                ),
              ),
              const YMargin(30),
              Text(
                'Selected Time',
                style: TextSizes.s16.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              const YMargin(10),
              const SelectSuggestedTimeWidget(),
              const Spacer(),
              AppButton(
                text: "Cancel",
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  showCancelBottomSheet();
                },
              ),
              const YMargin(40)
            ],
          ),
        );
      }
    );
  }

  showCancelBottomSheet() {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(30),
                Row(
                  children: [
                    Text(
                      "Cancel This Call?",
                      style: TextStyle(
                        fontSize: config.sp(22),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const YMargin(20),
                const AppTextField(
                  hint: "Enter a reason for canceling this call",
                  maxLines: 5,
                ),
                const Spacer(),
                AppButton(
                  text: "Cancel",
                  color: Colors.red,
                  onPressed: () {},
                ),
                const YMargin(40)
              ],
            ),
          ),
        );
      }
    );
  }
}