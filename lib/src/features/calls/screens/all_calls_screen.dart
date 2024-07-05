
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/core/presentation/widgets/past_call_widget.dart';
import 'package:earnwise/src/core/presentation/widgets/upcoming_call_widget.dart';
import 'package:earnwise/src/features/calls/screens/request_calls_screen.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AllCallsScreen extends ConsumerStatefulWidget {
  const AllCallsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllCallsScreenState();
}

class _AllCallsScreenState extends ConsumerState<AllCallsScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callViewModel).getUserCalls();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var callProvider = ref.watch(callViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YMargin(20),
          Row(
            children: [
              const XMargin(5),
              Text(
                "Upcoming Calls",
                style: TextStyle(
                  fontSize: config.sp(18),
                  fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                  "See All"
                )
              ),
              const XMargin(5),
            ],
          ),
          if(callProvider.upcomingCallRequests.isEmpty)...[
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/empty_state.json",
                    height: config.sh(100),
                    width: config.sw(100),
                    alignment: Alignment.center
                  ),
                  const YMargin(10),
                  Text(
                    "You do not have any upcoming calls",
                    textAlign: TextAlign.center,
                    style: TextSizes.s14.copyWith(),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
              separatorBuilder: (context, index) => const Divider(height: 20, thickness: .5,),
              itemBuilder: (context, index) {
                var call = callProvider.upcomingCallRequests[index];

                return UpcomingCallWidget(
                  request: call,
                );
              },
              itemCount: callProvider.upcomingCallRequests.take(5).length,
            ),
          ],
          
      
          const YMargin(20),
      
          Row(
            children: [
              const XMargin(5),
              Text(
                "Recents",
                style: TextStyle(
                  fontSize: config.sp(18),
                  fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                  "See All"
                )
              ),
              const XMargin(5),
            ],
          ),
          if(callProvider.pastCallRequests.isEmpty)...[
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/empty_state.json",
                    height: config.sh(100),
                    width: config.sw(100),
                    alignment: Alignment.center
                  ),
                  const YMargin(10),
                  Text(
                    "You have not received any calls yet",
                    textAlign: TextAlign.center,
                    style: TextSizes.s14.copyWith(),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 20),
              itemBuilder: (context, index) {
                return PastCallWidget(
                  request: callProvider.pastCallRequests[index],
                );
              },
              itemCount: callProvider.pastCallRequests.length,
            ),
          ],
          
        ],
      ),
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