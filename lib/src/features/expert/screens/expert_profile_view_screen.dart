import 'package:earnwise/src/core/domain/response/expert_profile.dart';
import 'package:earnwise/src/features/profile/screens/expert_profile_screen.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ExpertProfileViewScreen extends ConsumerStatefulWidget {
  const ExpertProfileViewScreen({super.key, this.profile});

  final ExpertProfile? profile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpertProfileViewScreenState();
}

class _ExpertProfileViewScreenState extends ConsumerState<ExpertProfileViewScreen> {

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
              push(const ExpertProfileScreen());
            }, 
            icon: const Icon(Icons.info_outline), 
            label: Text(
              "Edit Expert Profile",
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: SingleChildScrollView(
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
                "Created on ${widget.profile?.createdAt?.split("T").first}",
                style: TextSizes.s12.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              
              const YMargin(20),
              Center(
                child: Image.network(
                  "${widget.profile?.coverImage}",
                  height: config.sh(250),
                  fit: BoxFit.contain,
                ),
              ),
              const YMargin(20),
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
        ),
      ),
    );
  }
}