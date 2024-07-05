import 'package:earnwise/src/features/calls/screens/past_calls_screen.dart';
import 'package:earnwise/src/features/calls/screens/request_calls_screen.dart';
import 'package:earnwise/src/features/calls/screens/sent_requests_screen.dart';
import 'package:earnwise/src/features/calls/screens/all_calls_screen.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class CallsScreen extends ConsumerStatefulWidget {
  const CallsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallsScreenState();
}

class _CallsScreenState extends ConsumerState<CallsScreen> {

  String? selectedTab = "All";

  final controller = PageController(
    keepPage: true,
    initialPage: 0
  );

  int currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });

    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 1,
        title: Text(
          "Calls",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
        actions:[ 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ["All", "Requests"].map((e) {
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if(e == "All") {
                    onPageChanged(0);
                  } else if(e == "Requests") {
                    onPageChanged(1);
                  }
                  setState(() {
                    selectedTab = e;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: config.sw(5)),
                  padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(5)),
                  decoration: BoxDecoration(
                    color: selectedTab == e ? Palette.purpleText : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Text(
                        e,
                        style: TextSizes.s14.copyWith(
                          color: !isDarkMode && selectedTab == e  
                            ? Colors.white 
                            : isDarkMode && selectedTab == e
                            ? Colors.white
                            : isDarkMode && selectedTab != e
                            ? Colors.white
                            : Colors.black
                        ),
                      ),
                      // const XMargin(5),
                      // if(e != "Past")...[
                      //   Container(
                      //     padding: const EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: e == "Active" ? Colors.green : Colors.red
                      //     ),
                      //     child: Text(
                      //       "2",
                      //       style: TextSizes.s12.copyWith(
                      //         fontWeight: FontWeight.bold
                      //       ),
                      //     ),
                      //   )
                      // ],
                      
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ]
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: onPageChanged,
                children: const [
                  AllCallsScreen(),
                  CallRequestsScreen(),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}