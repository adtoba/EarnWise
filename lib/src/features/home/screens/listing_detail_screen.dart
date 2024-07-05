import 'package:earnwise/src/core/domain/response/expert_profile.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/features/home/screens/new_request_screen.dart';
import 'package:earnwise/src/features/profile/screens/expert_profile_screen.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';


class ListingDetailScreen extends ConsumerStatefulWidget {
  const ListingDetailScreen({super.key, this.profile});

  final ExpertProfile? profile;

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
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.ios_share), 
            label: Text(
              "Share",
              style: TextSizes.s14.copyWith(
                fontWeight: FontWeight.bold
              ),
            )
          ),
          TextButton.icon(
            onPressed: () {
              push(ExpertProfileScreen(
                userId: widget.profile?.userId,
                expertId: widget.profile?.id,
              ));
            }, 
            icon: const Icon(Icons.info_outline), 
            label: Text(
              "About This Expert",
              style: TextSizes.s14.copyWith(
                fontWeight: FontWeight.bold
              ),
            )
          ),
          // TextButton.icon(
          //   onPressed: () {
          //     push(const ExpertProfileScreen());
          //   }, 
          //   icon: Icon(
          //     Icons.info_outline, 
          //     color: isDarkMode 
          //       ? Colors.white 
          //       : Colors.black
          //   ),
          //   label: Text(
          //     "About This Expert",
          //     style: TextSizes.s16.copyWith(
          //       color: isDarkMode ? Colors.white : Colors.black,
          //       fontWeight: FontWeight.bold
          //     ),
          //   )
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.profile!.topics!.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(.2)
                      ),
                      child: Text(
                        "# $e"
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(30),
                  Text(
                    "${widget.profile?.title}",
                    style: TextSizes.s18.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: config.sp(19)
                    ),
                  ),
                  Text(
                    "Posted on ${Jiffy.parse(widget.profile!.createdAt!).yMMMEdjm}",
                    style: TextSizes.s12.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),
                  const YMargin(10),
                  Center(
                    child: Image.network(
                      widget.profile!.coverImage!,
                      height: config.sh(200),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const YMargin(10),
                  Text(
                    "${widget.profile?.description}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black
                    ),
                  ),
                  const YMargin(40),
                ],
              ),
            )
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
                  text: "Request a Call (\$${widget.profile?.hourlyRate} per hour)",
                  onPressed: () async {
                    // String? userId = await LocalStorage.get(SharedPrefs.userId);

                    // push(CallPage(
                    //   userId: userId,
                    //   callId: "12345678",
                    // ));
                    push(NewRequestScreen(
                      expertName: widget.profile?.fullName,
                      expertId: widget.profile?.id,
                      hourlyRate: widget.profile?.hourlyRate,
                      expertProfilePic: widget.profile?.coverImage,
                    ));
                  },
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