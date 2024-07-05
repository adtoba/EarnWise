import 'package:earnwise/src/core/domain/dto/create_call_request.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_dropdownfield.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/features/home/widgets/primary_loading_indicator.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/toast.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';


class NewRequestScreen extends ConsumerStatefulWidget {
  const NewRequestScreen({super.key, this.expertName, this.expertId, this.expertProfilePic, this.hourlyRate});

  final String? expertName;
  final String? expertId;
  final String? expertProfilePic;
  final double? hourlyRate;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends ConsumerState<NewRequestScreen> {

  String? selectedEstimatedTime;

  final pageController = PageController(
    keepPage: true,
    initialPage: 0
  );

  int currentIndex = 0;

  int minutes = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    
    pageController.jumpToPage(index);
  }

  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  final estimatedLengthController = TextEditingController();

  var date = Jiffy.parseFromDateTime(DateTime.now()).yMMMEd;

  DateTime? firstSelectedDate;
  TimeOfDay? firstSelectedTime;

  DateTime? secondSelectedDate;
  TimeOfDay? secondSelectedTime;

  DateTime? thirdSelectedDate;
  TimeOfDay? thirdSelectedTime;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      firstSelectedDate = DateTime.now();
      secondSelectedDate = DateTime.now();
      thirdSelectedDate = DateTime.now();
      
      firstSelectedTime = TimeOfDay.now();
      secondSelectedTime = TimeOfDay.now();
      thirdSelectedTime = TimeOfDay.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var callsProvider = ref.watch(callViewModel);
    return LoadingOverlay(
      isLoading: callsProvider.isLoading,
      progressIndicator: const PrimaryLoadingIndicator(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              if(currentIndex == 1) {
                
                onPageChanged(0);
              } else {
                Navigator.pop(context);
              }
            }, 
            icon: const Icon(Icons.arrow_back_ios)
          ),
          elevation: 1,
          title: Text(
            currentIndex == 0 
              ? "New Request"
              : "Suggest a Time",
            style: TextStyle(
              fontSize: config.sp(22),
              fontFamily: GoogleFonts.raleway().fontFamily,
              fontWeight: FontWeight.bold
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 20), 
            child: LinearProgressIndicator(
              value: currentIndex == 0 ? 0.5 : 0.9,
              valueColor: const AlwaysStoppedAnimation(Colors.orange),
            )
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const YMargin(20),
                    AppTextField(
                      controller: reasonController,
                      hint: "Please enter a reason for the call",
                      maxLines: 4,
                      validator: Validators.validateField,
                    ),
                    const YMargin(20),
                    AppDropDownDynamic(
                      hint: "Select Estimated Call Length",
                      selected: selectedEstimatedTime,
                      validator: (val) {
                        if(val is String) {
                          if(val.isEmpty) {
                            return "Field cannot be empty";
                          } else {
                            return null;
                          }
                        }
                        return null;
                      },
                      options: <String>[
                        '15 minutes (\$${widget.hourlyRate! / 4})',
                        '30 minutes (\$${widget.hourlyRate! / 2})',
                        '1 hour (\$${widget.hourlyRate})',
                      ], 
                      onChanged: (val) {
                        setState(() {
                          selectedEstimatedTime = val;
                        });
                      },
                      getDisplayName: (val) {
                        return val;
                      }
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(20),
                  SelectTimeWidget(
                    selectedDate: firstSelectedDate,
                    selectedTime: firstSelectedTime,
                    onDateChanged: (date) {
                      setState(() {
                        if(date != null) {
                          firstSelectedDate = date;
                        }
                        
                      });
                    },
                    onTimeChanged: (time) {
                      setState(() {
                        if(time != null) {
                          firstSelectedTime = time;
                        }
                        
                      });
                    },
                  ),
                  
                  const YMargin(20),
                  SelectTimeWidget(
                    selectedDate: secondSelectedDate,
                    selectedTime: secondSelectedTime,
                    onDateChanged: (date) {
                      setState(() {
                        if(date != null) {
                          secondSelectedDate = date;
                        }
                        
                      });
                    },
                    onTimeChanged: (time) {
                      setState(() {
                        if(time != null) {
                          secondSelectedTime = time;
                        }
                        
                      });
                    },
                  ),
      
                  const YMargin(20),
                  SelectTimeWidget(
                    selectedDate: thirdSelectedDate,
                    selectedTime: thirdSelectedTime,
                    onDateChanged: (date) {
                      
                      setState(() {
                        if(date != null) {
                          thirdSelectedDate = date;
                        }
                        
                      });
                    },
                    onTimeChanged: (time) {
                      setState(() {
                        if(time != null) {
                          thirdSelectedTime = time;
                        }
                        
                      });
                    },
                  ),

                  const YMargin(20),
                  const Text(
                    "You can choose up to 3 dates and times that you will be available",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
            child: AppButton(
              text: currentIndex == 0 ? "Next" : "Proceed",
              onPressed: () {
                if(currentIndex == 0) {
                  if(formKey.currentState!.validate()) {
                    if(selectedEstimatedTime == null) {
                      showErrorToast("You must select a call length");
                    } else {
                      callsProvider.callReason = reasonController.text;
                      
                      var timeSplit = selectedEstimatedTime?.split(' ').first;
                      if(timeSplit != null) {
                        int time = int.parse(timeSplit);
                        if(time == 1) {
                          minutes = 60;
                        } else {
                          minutes = time;
                        }
                      }
                      print(selectedEstimatedTime);
                      callsProvider.totalMinutes = minutes;
                      onPageChanged(1);
                    }
                  }
                } else {
                  callsProvider.suggestedTimes.clear();
                  
                  var date1 = callsProvider.joinDateAndTime(firstSelectedDate!, firstSelectedTime!);
                  var date2 = callsProvider.joinDateAndTime(secondSelectedDate!, secondSelectedTime!);
                  var date3 = callsProvider.joinDateAndTime(thirdSelectedDate!, thirdSelectedTime!);
                  callsProvider.addTime(date1.toIso8601String());
                  callsProvider.addTime(date2.toIso8601String());
                  callsProvider.addTime(date3.toIso8601String());

                  callsProvider.createCall(CreateCallRequest(
                    reason: callsProvider.callReason,
                    totalMinutes: callsProvider.totalMinutes,
                    expertName: widget.expertName,
                    expertId: widget.expertId,
                    expertProfilePic: widget.expertProfilePic,
                    hourlyRate: widget.hourlyRate,
                    suggestedTimes: callsProvider.suggestedTimes,
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}


class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key, this.onTimeChanged, this.onDateChanged, this.hint, this.selectedDate, this.selectedTime});

  final Function(TimeOfDay?)? onTimeChanged;
  final Function(DateTime?)? onDateChanged;
  final String? hint;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  
  @override
  Widget build(BuildContext context) {

    return Container(
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
            child: InkWell(
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context, 
                  firstDate: DateTime.now(), 
                  lastDate: DateTime(2025)
                );
                if(date != null) {
                  print(date.toString());
                  onDateChanged!(date);
                }
              },
              child: Row(
                children: [
                  // const Icon(Icons.calendar_month),
                  // const XMargin(10),
                  Expanded(
                    child: Text(
                      "${Jiffy.parseFromDateTime(selectedDate!).yMMMEd}",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
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
            child: InkWell(
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context, 
                  initialTime: TimeOfDay.now(),
                );
                if(time != null) {
                  onTimeChanged!(time);
                }
              },
              child: Row(
                children: [
                  // const Icon(Icons.more_time),
                  const XMargin(10),
                  Expanded(
                    child: Text(
                      "${selectedTime?.format(context)}",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}