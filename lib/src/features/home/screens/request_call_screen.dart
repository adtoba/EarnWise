import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/home/screens/request_call_success_page.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class RequestCallScreen extends ConsumerStatefulWidget {
  const RequestCallScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: const Column(
              children: [
                YMargin(20),
                AppTextField(
                  hint: "Please enter a reason for the call",
                  maxLines: 4,
                ),
                YMargin(20),
                AppTextField(
                  hint: "Select Estimated Length",
                  suffix: Icon(Icons.arrow_drop_down),
                ),
              ],
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
                onPageChanged(1);
              } else {
                push(const RequestCallSuccessPage());
              }
            },
          ),
        )
      ],
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
                  Expanded(
                    child: Text(
                      "Apr 23, 2024",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  const Icon(Icons.unfold_more)
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
                  Expanded(
                    child: Text(
                      "4:00 PM",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  const Icon(Icons.unfold_more)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}