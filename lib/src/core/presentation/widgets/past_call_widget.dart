import 'package:earnwise/src/core/domain/response/call_response.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

class PastCallWidget extends ConsumerStatefulWidget {
  const PastCallWidget({super.key, this.request});

  final CallResponse? request;

  @override
  ConsumerState<PastCallWidget> createState() => _PastCallWidgetState();
}

class _PastCallWidgetState extends ConsumerState<PastCallWidget> {
  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: config.sw(5), vertical: config.sh(10)),
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
                      "ended on ${Jiffy.parse(widget.request!.acceptedTime!).yMMMMdjm}",
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
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey,
              )
            ],
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
                                    "${Jiffy.parse(suggestedTime).yMMMEdjm}",
                                    style: TextSizes.s16.copyWith(
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              );
                            }, 
                            separatorBuilder: (c, i) => const YMargin(10), 
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
                    isLoading: ref.watch(callViewModel).isLoading,
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