import 'package:earnwise/src/core/domain/dto/create_call_request.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/features/home/widgets/primary_loading_indicator.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';


class RequestCallScreen extends ConsumerStatefulWidget {
  const RequestCallScreen({super.key, this.expertName, this.expertId, this.expertProfilePic});

  final String? expertName;
  final String? expertId;
  final String? expertProfilePic;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestCallScreenState();
}

class _RequestCallScreenState extends ConsumerState<RequestCallScreen> {

  final pageController = PageController(
    keepPage: true,
    initialPage: 0
  );

  int currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    
    pageController.jumpToPage(index);
  }

  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  final estimatedLengthController = TextEditingController();

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
                    AppTextField(
                      controller: estimatedLengthController,
                      hint: "Select Estimated Call Length",
                      suffix: const Icon(Icons.arrow_drop_down),
                      validator: Validators.validateField,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(20),
                  SelectTimeWidget(),
                  
                  YMargin(20),
                  SelectTimeWidget(),
      
                  YMargin(20),
                  SelectTimeWidget()
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
                    callsProvider.callReason = reasonController.text;
                    callsProvider.totalMinutes = int.parse(estimatedLengthController.text);
                    onPageChanged(1);
                  }
                } else {
                  callsProvider.addTime("2024-04-29");
                  callsProvider.createCall(CreateCallRequest(
                    reason: callsProvider.callReason,
                    totalMinutes: callsProvider.totalMinutes,
                    expertName: widget.expertName,
                    expertId: widget.expertId,
                    expertProfilePic: widget.expertProfilePic,
                    hourlyRate: 100,
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
  const SelectTimeWidget({super.key});

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
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const XMargin(10),
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
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.timelapse),
                  const XMargin(10),
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
            ),
          )
        ],
      ),
    );
  }
}