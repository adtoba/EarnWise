import 'package:earnwise/src/features/expert/screens/create_expert_screen.dart';
import 'package:earnwise/src/features/home/screens/listing_detail_screen.dart';
import 'package:earnwise/src/features/profile/screens/settings_page.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/extensions.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with TickerProviderStateMixin {

  late TabController _tabController;

  int currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
          "Profile",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              push(const SettingsPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(20)),
              decoration: BoxDecoration(
                color: Palette.appBarColor.withOpacity(.2)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: config.sh(80),
                        width: config.sw(80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/person.jpeg",
                            ),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      const YMargin(10),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star_outline, color: Colors.grey),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  MaterialButton(
                    height: config.sh(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)
                    ),
                    color: Palette.purpleText,
                    onPressed: () {
                      push(const CreateExpertScreen());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: Colors.white),
                        const XMargin(10),
                        Text(
                          "Create Expert Profile",
                          style: TextStyle(
                            fontFamily: "",
                            fontSize: config.sp(14),
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const YMargin(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Adebisi Habib",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold, fontSize: config.sp(22)
                        ),
                      ),
                      const XMargin(10),
                      const Icon(Icons.verified, color: Colors.green),
                    ],
                  ),
                  const YMargin(5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mobile Developer",
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const XMargin(10),
                      Text(
                        "\u2022",
                        style: TextSizes.s16.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const XMargin(10),
                      Text(
                        "120 ",
                        style: TextSizes.s16.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const Text(
                        "Calls"
                      ),
                    ],
                  ),
                  const YMargin(5),
                  Text(
                    "Explorer of dreams, architect of ambition, and curator of compelling stories. Join me on a journey through the extraordinary twists and turns of life's narrative.",
                    textAlign: TextAlign.justify,
                    style: TextSizes.s14.copyWith(
                      fontSize: config.sp(15)
                    ),
                  ),
                  const YMargin(10),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const XMargin(5),
                      Text(
                        "Lagos, Nigeria",
                        style: TextSizes.s14.copyWith(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const XMargin(10),
                      Text(
                        "\u2022",
                        style: TextSizes.s16.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const XMargin(10),
                      ImageIcon(
                        AssetImage(
                          "instagram".png
                        ),
                        size: 20,
                      ),
                      const XMargin(10),
                      ImageIcon(
                        AssetImage(
                          "twitter".png
                        ),
                        size: 20,
                      ),
                      const XMargin(10),
                      ImageIcon(
                        AssetImage(
                          "linkedin".png
                        ),
                        size: 20,
                      )
                    ],
                  ),
                  const YMargin(20),
                  const Divider(),
                  TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: isDarkMode ? Colors.white : Colors.black,
                    onTap: onTabChanged,
                    labelStyle: TextStyle(
                      fontSize: config.sp(15),
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontFamily: GoogleFonts.raleway().fontFamily
                    ),
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.reviews_outlined),
                            // XMargin(10),
                            Text(
                              "Reviews (90)"
                            )
                          ],
                        )
                      ),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.favorite_border),
                            // XMargin(10),
                            Text(
                              "Saved (10)"
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                  if(currentIndex == 0)...[
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: config.sh(20)),
                      physics: const NeverScrollableScrollPhysics(),
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
                            style: TextSizes.s14.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: config.sp(13),
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
                      separatorBuilder: (c, i) => Divider(height: config.sh(20)), 
                      itemCount: 5
                    ),
                  ] else ...[
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: config.sh(20)),
                      itemBuilder: (c, i) {
                        return InkWell(
                          onTap: () {
                            push(const ListingDetailScreen());
                          },
                          child: Row(
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
                                        fontSize: config.sp(14),
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
                          ),
                        );
                      }, 
                      separatorBuilder: (c, i) => const Divider(height: 20), 
                      itemCount: 5
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    
  }
}