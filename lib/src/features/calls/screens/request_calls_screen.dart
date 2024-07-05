import 'package:earnwise/src/core/domain/response/call_response.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/toast.dart';
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
    var callProvider = ref.watch(callViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YMargin(30),
          Row(
            children: [
              Text(
                "Received Requests",
                style: TextStyle(
                  fontSize: config.sp(18)
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                  "See All"
                )
              )
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(height: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var request = callProvider.receivedCallRequests[index];
              
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(
                    "assets/images/person.jpeg"
                  )
                ),
                title: Text(
                  "${request.reason}",
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
                        showAcceptBottomSheet(request);
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
            itemCount: callProvider.receivedCallRequests.take(4).length,
          ),

          YMargin(30),

          Row(
            children: [
              Text(
                "Sent Requests",
                style: TextStyle(
                  fontSize: config.sp(18)
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                  "See All"
                )
              )
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(height: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var request = callProvider.sentCallRequests[index];
              
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    "assets/images/person.jpeg"
                  )
                ),
                title: Text(
                  "${request.reason}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextSizes.s14.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black
                  ),
                ),
                subtitle: const Text(
                  "In 30 mins"
                ),
          
                // trailing: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         showAcceptBottomSheet();
                //       },
                //       child: Container(
                //         padding: const EdgeInsets.all(5),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Palette.primary
                //         ),
                //         child: const Icon(Icons.check, color: Colors.white),
                //       ),
                //     ),
                //     const XMargin(10),
                //     InkWell(
                //       onTap: () {
                //         showRejectBottomSheet();
                //       },
                //       child: Container(
                //         padding: const EdgeInsets.all(5),
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Colors.red
                //         ),
                //         child: const Icon(Icons.close, color: Colors.white),
                //       ),
                //     ),
                //   ],
                // )
              );
            },
            itemCount: callProvider.sentCallRequests.take(4).length,
          ),
        ],
      ),
    );
  }
  String? selectedTime;

  showAcceptBottomSheet(CallResponse request) {
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
                            "${request.reason}",
                            style: TextSizes.s16.copyWith(
                              fontWeight: FontWeight.normal,
                              color: isDarkMode ? Colors.white : Colors.black
                            ),
                          ),
                          const YMargin(30),
                          Text(
                            'Choose a Time',
                            style: TextSizes.s16.copyWith(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const YMargin(20),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var suggestedTime = request.suggestedTimes![index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTime = suggestedTime;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(15)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: suggestedTime == selectedTime ? Colors.red : Colors.grey
                                    )
                                  ),
                                  child: Text(
                                    suggestedTime,
                                    style: TextSizes.s16.copyWith(
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              );
                            }, 
                            separatorBuilder: (c, i) => const YMargin(5), 
                            itemCount: request.suggestedTimes!.length
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
                  AppButton(
                    text: "Accept",
                    color: Colors.green,
                    onPressed: () async {
                      if(selectedTime != null) {
                        ref.read(callViewModel).acceptCall(request.id!, selectedTime!);
                      } else {
                        showErrorToast("You must select a time");
                      }
                      
                    },
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