import 'package:earnwise/src/core/presentation/widgets/location_socials_widget.dart';
import 'package:earnwise/src/core/presentation/widgets/review_widget.dart';
import 'package:earnwise/src/features/expert/screens/create_expert_screen.dart';
import 'package:earnwise/src/features/expert/screens/expert_profile_view_screen.dart';
import 'package:earnwise/src/features/home/widgets/primary_loading_indicator.dart';
import 'package:earnwise/src/features/profile/screens/settings_page.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/features/review/screens/all_reviews_screen.dart';
import 'package:earnwise/src/features/review/view_model/review_vm.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {


  int currentIndex = 0;

  @override
  void initState() {
    // ref.read(expertViewModel).getExpertProfile();
    ref.read(profileViewModel).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);
    var reviewProvider = ref.watch(reviewViewModel);
    var profile = profileProvider.profileResponse;
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
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.archive_outlined),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              push(const SettingsPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: profileProvider.isLoading 
        ? const PrimaryLoadingIndicator()
        : Column(
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
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: profile?.rating ?? 0,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star, 
                              color: Colors.orange
                            ),
                            itemCount: 5,
                            itemSize: 20,
                            direction: Axis.horizontal,
                          ),
                          const XMargin(5),
                          Text(
                            "(${profile?.totalRatings})",
                            style: TextSizes.s14,
                          )
                        ],
                      ),
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
                      if(profileProvider.profileResponse?.expertProfile == null) {
                        push(const CreateExpertScreen());
                      } else {
                        push(ExpertProfileViewScreen(
                          profile: profileProvider.profileResponse?.expertProfile,
                        ));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          profileProvider.profileResponse?.expertProfile == null 
                            ? Icons.add
                            : Icons.remove_red_eye_outlined, 
                          color: Colors.white
                        ),
                        const XMargin(10),
                        Text(
                          profileProvider.profileResponse?.expertProfile == null 
                            ? "Create Expert Profile"
                            : "See Expert Profile",
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
                        profile?.fullName ?? "Adebisi Habib",
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
                      Text(
                        profile?.professionalTitle ?? "Mobile Developer",
                        style: const TextStyle(
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
                        profile?.totalCalls.toString() ?? "120",
                        style: TextSizes.s16.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const Text(
                        " Calls"
                      ),
                    ],
                  ),
                  const YMargin(5),
                  Text(
                    profile?.bio ?? "Explorer of dreams, architect of ambition, and curator of compelling stories. Join me on a journey through the extraordinary twists and turns of life's narrative.",
                    textAlign: TextAlign.justify,
                    style: TextSizes.s14.copyWith(
                      fontSize: config.sp(15)
                    ),
                  ),
                  const YMargin(10),
                  LocationSocialsWidget(
                    location: profile?.location,
                  ),
                  const YMargin(20),
                  FutureBuilder(
                    future: reviewProvider.getMyReviews(), 
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return const PrimaryLoadingIndicator();
                      }
                      
                      if(!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Text(
                              "Reviews (0)",
                              style: TextSizes.s16.copyWith(
                                fontSize: config.sp(24)
                              ),
                            ),
                            const YMargin(30),
                            Center(
                              child: Text(
                                "No reviews yet",
                                style: TextStyle(
                                  fontSize: config.sp(15)
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      
                      return Column(
                        children: [
                          const Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Reviews (${snapshot.data!.length})",
                                style: TextSizes.s16.copyWith(
                                  fontSize: config.sp(24)
                                ),
                              ),
                              const Spacer(),
                              if(snapshot.data!.isNotEmpty)...[     
                                TextButton.icon(
                                  onPressed: () {
                                    push(AllReviewPage(
                                      reviews: snapshot.data,
                                    ));
                                  }, 
                                  icon: const Text(
                                    "See All"
                                  ),
                                  label: const Icon(
                                    Icons.arrow_forward_ios, 
                                    size: 10
                                  ),
                                )
                              ],
                            ],
                          ),
                          if(snapshot.data!.isEmpty)...[
                            const YMargin(30),
                            Center(
                              child: Text(
                                "No reviews yet",
                                style: TextStyle(
                                  fontSize: config.sp(15)
                                ),
                              ),
                            ),
                          ] else ...[
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: config.sh(20)),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (c, i) {
                                var review = snapshot.data![i];
                                return ReviewWidget(review: review);
                              }, 
                              separatorBuilder: (c, i) => Divider(height: config.sh(20)), 
                              itemCount: snapshot.data!.take(5).length
                            ),
                          ],
                          
                        ],
                      );
                    }
                  ),
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