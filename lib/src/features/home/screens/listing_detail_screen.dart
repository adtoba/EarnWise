import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/features/profile/screens/expert_profile_screen.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ListingDetailScreen extends ConsumerStatefulWidget {
  const ListingDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends ConsumerState<ListingDetailScreen> {

  String? selectedTab = "Post";

  PageController controller = PageController(
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
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () {
              push(const ExpertProfileScreen());
            }, 
            child: Text(
              "About This Expert",
              style: TextSizes.s16.copyWith(
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(20),
              Text(
                "Narcissistic Personality Disorder Abuse",
                style: TextSizes.s18.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: config.sp(19)
                ),
              ),
              Text(
                "Posted 20 hours ago",
                style: TextSizes.s12.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              const YMargin(20),
              Center(
                child: Image.asset(
                  "assets/images/narcissist.jpg",
                  height: config.sh(300),
                  fit: BoxFit.cover,
                ),
              ),
              const YMargin(20),
              Text(
                "Do you feel powerless, emotionally drained, frustrated, or guilt ridden every time you interact with your parents? Have you been suffering from unexplained depression, self-esteem issues, anger, and/or anxiety for most of your life and have never been able to put your finger on exactly why? If so you may be an adult child of a parent with Narcissistic Personality Disorder. At first it may be difficult for you to attribute NPD abuse to how you are feeling, but many AHA moments.will arise for you as you awaken to the facts about this disorder.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black
                ),
              ),
              const YMargin(40),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const XMargin(10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: config.sh(5)),
                child: AppButton(
                  text: "Request a Call (\$5 per min)",
                  onPressed: () {},
                ),
              ),
            ),
            const XMargin(20),
            IconButton(
              icon: const Icon(Icons.favorite_border, size: 30),
              onPressed: () {},
            ),
            const XMargin(10),
          ],
        )
      ],
    );
  }
}