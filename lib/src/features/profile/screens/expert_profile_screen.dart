import 'package:earnwise/src/core/domain/response/get_profile_response.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/features/review/screens/create_review_screen.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/extensions.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ExpertProfileScreen extends ConsumerStatefulWidget {
  const ExpertProfileScreen({super.key, this.userId});
  final String? userId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends ConsumerState<ExpertProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 1,
        title: Text(
          "About This Expert",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: FutureBuilder<GetProfileResponse?>(
        future: profileProvider.getUserProfileById(userId: widget.userId), 
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: Text(
                "Profile Not Found"
              ),
            );
          }

          return SingleChildScrollView(
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
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: snapshot.data?.rating ?? 0,
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
                                "(${snapshot.data?.totalRatings})",
                                style: TextSizes.s14,
                              )
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
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(Icons.chat, color: Colors.white),
                            const XMargin(10),
                            Text(
                              "Send Message",
                              style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
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
                            "${snapshot.data?.fullName}",
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
                            "${snapshot.data?.professionalTitle}",
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
                            "${snapshot.data?.totalCalls} ",
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
                        "${snapshot.data?.bio}",
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
                            "${snapshot.data?.location}",
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Reviews (90)",
                            style: TextSizes.s16.copyWith(
                              fontSize: config.sp(24)
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              push(const CreateReviewScreen());
                            }, 
                            icon: const Icon(Icons.add)
                          )
                        ],
                      ),
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
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}