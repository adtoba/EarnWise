import 'package:earnwise/src/features/expert/view_model/expert_vm.dart';
import 'package:earnwise/src/features/home/screens/listing_detail_screen.dart';
import 'package:earnwise/src/features/home/widgets/listing_item.dart';
import 'package:earnwise/src/features/home/widgets/primary_loading_indicator.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  String? selectedTab = "Featured";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expertViewModel).getSuggestedExperts();
      ref.read(profileViewModel).getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var expertProvider = ref.watch(expertViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 1,
        scrolledUnderElevation: 0,
        title: Text(
          "Explore",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search)
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.notifications)
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
                      color: selectedTab == e 
                        ? Palette.purpleText
                        : Colors.transparent,
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
            if(expertProvider.isLoading)...[
              const Expanded(
                child: PrimaryLoadingIndicator()
              )
            ] else if(expertProvider.suggestedExperts.isEmpty)...[
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset(
                        "assets/empty_state.json",
                        height: config.sh(200),
                        width: config.sw(200),
                        alignment: Alignment.center
                      ),
                      const YMargin(20),
                      Text(
                        "We could not find experts based on your interests.\nWe will keep searching for available experts.",
                        textAlign: TextAlign.center,
                        style: TextSizes.s14.copyWith(

                        ),
                      ),
                    ],
                  ),
                ),
              )
            ] else ...[
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (c, i) {
                    var expertProfile = expertProvider.suggestedExperts[i];
                    return ListingItem(
                      image: expertProfile.coverImage,
                      rating: expertProfile.ratings,
                      totalReviews: expertProfile.totalReviews,
                      userName: expertProfile.fullName,
                      title: expertProfile.title,
                      description: expertProfile.description,
                      onTap: () {
                        push(ListingDetailScreen(
                          profile: expertProfile,
                        ));
                      },
                    );
                  }, 
                  separatorBuilder: (c, i) => const Divider(height: 20), 
                  itemCount: expertProvider.suggestedExperts.length
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}