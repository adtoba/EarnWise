import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(20),
            Row(
              children: ["Post", "About Poster"].map((e) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if(e == "Post") {
                      onPageChanged(0);
                    } else {
                      onPageChanged(1);
                    }
                    setState(() {
                      selectedTab = e;
                    });
                  },
                  child: Container(
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
                onPageChanged: onPageChanged,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Narcissistic Personality Disorder Abuse",
                          style: TextSizes.s18.copyWith(
                            fontWeight: FontWeight.bold
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
              
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const YMargin(10),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/person.jpeg"
                            ),
                          ),
                          const XMargin(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Adebisi Habib",
                                  style: TextSizes.s16.copyWith(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  "Lagos, Nigeria",
                                  style: TextSizes.s12.copyWith(
                                    color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const YMargin(10),
                      Text(
                        "About Randi Fine, Privacy Policy, and Disclaimer Do you need support or counseling in dealing with Narcissistic Personality abuse issues, everyday life",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: config.sp(14),
                          
                        ),
                      ),
                      const YMargin(10),
                      Row(
                        children: [
                          const XMargin(20),
                  
                          const Icon(Icons.phone_outlined, color: Colors.grey),
                          const XMargin(10),
                          Text(
                            "121",
                            style: TextSizes.s16,
                          ),
                  
                          const Spacer(),
                          Container(
                            height: 20,
                            color: Colors.grey,
                            width: 1,
                          ),
                          const Spacer(),
                  
                          const Icon(Icons.star_outline, color: Colors.grey),
                          const XMargin(10),
                          Text(
                            "50",
                            style: TextSizes.s16,
                          ),
                  
                          const Spacer(),
                          Container(
                            height: 20,
                            color: Colors.grey,
                            width: 1,
                          ),
                          const Spacer(),
                  
                          const Icon(Icons.comment_bank_outlined, color: Colors.grey),
                          const XMargin(10),
                          Text(
                            "80",
                            style: TextSizes.s16,
                          ),
                          const XMargin(20)
                        ],
                      ),
                      const YMargin(30),
                      Text(
                        "Reviews (80)",
                        style: TextSizes.s18.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const YMargin(20),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  "assets/images/person.jpeg"
                                ),
                              ),
                              title: Text(
                                "I've been very impressed by Randi's books and podcasts and knowledge of her subject. She is easy to talk to with a kind disposition. I'm so glad she still takes individual sessions - Absolutely recommended.",
                                style: TextSizes.s12.copyWith(
                                  color: isDarkMode ? Colors.white : Colors.black
                                ),
                              ),
                              subtitle: const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Jun 21, 2024",
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ),
                            );
                          }, 
                          separatorBuilder: (c, i) => Divider(height: config.sh(40)), 
                          itemCount: 10
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
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