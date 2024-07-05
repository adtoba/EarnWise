import 'package:earnwise/src/core/domain/response/call_response.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/calls/screens/call_page.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

class UpcomingCallWidget extends ConsumerStatefulWidget {
  const UpcomingCallWidget({super.key, this.request});

  final CallResponse? request;

  @override
  ConsumerState<UpcomingCallWidget> createState() => _UpcomingCallWidgetState();
}

class _UpcomingCallWidgetState extends ConsumerState<UpcomingCallWidget> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

    @override
    void initState() {
      _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
      _animationController.repeat(reverse: true);
      super.initState();
    }
  
  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        showCallInfoSheet(widget.request!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(0), vertical: config.sh(10)),
        decoration: BoxDecoration(
          // color: Colors.grey.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: config.sh(50),
                  width: config.sw(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/person.jpeg'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                const XMargin(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.request?.userName}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextSizes.s14.copyWith(
                          fontSize: config.sp(16),
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black
                        ),
                      ),
                      Text(
                        callStatus(widget.request!) == 'ongoing' 
                          ? 'Ongoing'
                          : "Call starts on ${Jiffy.parse(widget.request!.acceptedTime!).yMMMMdjm}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextSizes.s14.copyWith(
                          fontSize: config.sp(14),
                          color: isDarkMode ? Colors.white : Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
                const XMargin(10),
                if(callStatus(widget.request!) == 'upcoming')...[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: config.sh(5), horizontal: config.sw(10)),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.close, size: 25, color: Colors.red),
                          onTap: () {
                            showRejectBottomSheet();
                          },
                        ),
                      ],
                    ),
                  ),
                ] else if(callStatus(widget.request!) == 'ongoing')...[
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Join Now",
                          style: TextStyle(
                            fontSize: config.sp(16),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const XMargin(10),
                        FadeTransition(
                          opacity: _animationController,
                          child: Container(
                            width: config.sw(10),
                            height: config.sh(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      print(widget.request!.id);
                      push(CallPage(
                        callId: widget.request!.id,
                        userId: ref.read(profileViewModel).profileResponse?.id,
                        userName: ref.read(profileViewModel).profileResponse?.fullName,
                      ));
                    },
                  )
                ],
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  String callStatus(CallResponse call) {
    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime.parse(call.acceptedTime!);
    DateTime endDateTime = DateTime.parse(call.acceptedTime!).add(Duration(minutes: call.totalMinutes!));

    if(now.isBefore(startDateTime)) {
      return 'upcoming';
    } else if(now.isAfter(endDateTime)) {
      return 'passed';
    } else {
      return 'ongoing';
    }
  }

  String? selectedTime;
  
  showCallInfoSheet(CallResponse request) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const YMargin(30),
                          Row(
                            children: [
                              Text(
                                "Call Info",
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
                            "${request.reason}",
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
                          const YMargin(20),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(15)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey
                              )
                            ),
                            child: Text(
                              Jiffy.parse(request.acceptedTime!).yMMMEdjm,
                              style: TextSizes.s16.copyWith(
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          // const SelectSuggestedTimeWidget(),
                          // const YMargin(10),
                          // const SelectSuggestedTimeWidget(),
                          // const YMargin(10),
                          // const SelectSuggestedTimeWidget(),
                        ],
                      ),
                    ),
                  ),
                  const YMargin(40)
                ],
              ),
            );
          }
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
                      "Cancel this call?",
                      style: TextStyle(
                        fontSize: config.sp(22),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const YMargin(20),
                const AppTextField(
                  hint: "Enter a reason for canceling the call",
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