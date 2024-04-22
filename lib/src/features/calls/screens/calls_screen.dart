import 'package:earnwise/src/features/calls/screens/past_calls_screen.dart';
import 'package:earnwise/src/features/calls/screens/upcoming_calls_screen.dart';
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

  String? selectedTab = "Upcoming";

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
          "Your Calls",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
        child: Column(
          children: [
            const YMargin(20),
            Row(
              children: ["Upcoming", "Past"].map((e) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if(e == "Upcoming") {
                      onPageChanged(0);
                    } else {
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
                      color: selectedTab == e ? Colors.grey.shade700 : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
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
                  ),
                );
              }).toList(),
            ),
            const YMargin(20),
            Expanded(
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: onPageChanged,
                children: const [
                  UpcomingScreen(),
                  PastScreen()
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}