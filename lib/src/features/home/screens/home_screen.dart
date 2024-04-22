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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 1,
        title: const Text(
          "Showing: Popular",
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
                          color: Colors.grey,
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