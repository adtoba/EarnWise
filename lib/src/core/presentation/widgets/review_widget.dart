import 'package:earnwise/src/core/domain/response/review_response.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jiffy/jiffy.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, this.review});

  final ReviewResponse? review;

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
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
                review?.review ?? "",
                style: TextSizes.s14.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: config.sp(13),
                  color: isDarkMode ? Colors.white : Colors.black
                ),
              ),
              const YMargin(5),
              Row(
                children: [
                  Expanded(
                    child: RatingBarIndicator(
                      rating: review?.rating ?? 0,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star, 
                        color: Colors.orange
                      ),
                      itemCount: 5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                    ),
                  ),
                  Text(
                    Jiffy.parse(review!.createdAt!).yMMMd,
                    style: const TextStyle(
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}