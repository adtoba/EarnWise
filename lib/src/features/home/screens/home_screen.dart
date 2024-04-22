import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  String? selectedTab = "Featured";

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
          "EarnWise",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {}, 
            label: const Text("Search"),
            icon: const Icon(Icons.search_sharp)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
        child: Column(
          children: [
            const YMargin(20),
            Row(
              children: ["Featured", "Popular", "New"].map((e) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
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
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Row(
                    children: [
                      Container(
                        height: config.sh(80),
                        width: config.sw(90),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/narcissist.jpg"
                            )
                          ),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                      const XMargin(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Narcissistic Personality Disorder Abuse",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextSizes.s14.copyWith(
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const YMargin(5),
                            Text(
                              "Adebisi Habib (232 Reviews)",
                              style: TextSizes.s12.copyWith(
                                color: Colors.grey
                              ),
                            ),
                            const YMargin(5),
                            Text(
                              "Absolutely spectacular!!!! For the past 2 years I have paid money for coaches and programs that have been a ton of work and really not given me the custom insight I needed to make strategic moves that propelled my business forward. My call with Adrian today was absolutely what I have been searching for. Personalized and strategic insight from an entrepreneur that has personally achieved what I am working to accomplish. Better investment than any coaching program. Highly recommend!!",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextSizes.s14,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }, 
                separatorBuilder: (c, i) => const Divider(height: 20), 
                itemCount: 30
              ),
            )
          ],
        ),
      ),
    );
  }
}