import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/extensions.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ExpertProfileScreen extends ConsumerStatefulWidget {
  const ExpertProfileScreen({super.key});

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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Reviews (90)",
                        style: TextSizes.s16.copyWith(
                          fontSize: config.sp(24)
                        ),
                      )
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: config.sh(20)),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (c, i) {
                      // return Row(
                      //   children: [
                      //     const CircleAvatar(
                      //       radius: 20,
                      //       backgroundImage: AssetImage(
                      //         "assets/images/person.jpeg"
                      //       ),
                      //     ),
                      //     XMargin(10),
                      //     Expanded(
                      //       child: Container(
                      //         padding: EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           border: Border.all(
                      //             width: .5,
                      //             color: Colors.grey
                      //           )
                      //         ),
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //               "I've been very impressed by Randi's books and podcasts and knowledge of her subject. She is easy to talk to with a kind disposition. I'm so glad she still takes individual sessions - Absolutely recommended.",
                      //               style: TextSizes.s14.copyWith(
                      //                 fontWeight: FontWeight.w400,
                      //                 fontSize: config.sp(13),
                      //                 color: isDarkMode ? Colors.white : Colors.black
                      //               ),
                      //             ),
                      //             const Align(
                      //               alignment: Alignment.centerRight,
                      //               child: Text(
                      //                 "Jun 21, 2024",
                      //                 style: TextStyle(
                      //                   fontSize: 12
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // );
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
      ),
    );
  }
}