import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallRequestsScreen extends ConsumerStatefulWidget {
  const CallRequestsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallRequestsScreenState();
}

class _CallRequestsScreenState extends ConsumerState<CallRequestsScreen> {

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

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  showAcceptBottomSheet();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.primary
                  ),
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ),
              const XMargin(10),
              InkWell(
                onTap: () {
                  showRejectBottomSheet();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          )
        );
      },
      itemCount: 2,
    );
  }

  showAcceptBottomSheet() {
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
                    "Request Info",
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
                'Choose a Suggested Time',
                style: TextSizes.s16.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              const YMargin(10),
              const SelectSuggestedTimeWidget(),
              const YMargin(10),
              const SelectSuggestedTimeWidget(),
              const YMargin(10),
              const SelectSuggestedTimeWidget(),
              const Spacer(),
              AppButton(
                text: "Accept",
                color: Colors.green,
                onPressed: () {},
              ),
              const YMargin(40)
            ],
          ),
        );
      }
    );
  }

  showRejectBottomSheet() {

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
                      "Decline Request?",
                      style: TextStyle(
                        fontSize: config.sp(22),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const YMargin(20),
                const AppTextField(
                  hint: "Enter a reason for declining the request",
                  maxLines: 5,
                ),
                const Spacer(),
                AppButton(
                  text: "Decline",
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

class SelectSuggestedTimeWidget extends StatelessWidget {
  const SelectSuggestedTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey
          )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Apr 23, 2024",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const XMargin(10),
            Container(
              height: config.sh(20),
              width: config.sw(1),
              color: Colors.grey,
            ),
            const XMargin(10),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "4:00 PM",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}