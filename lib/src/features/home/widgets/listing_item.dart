import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({
    super.key, 
    this.title, 
    this.image, 
    this.userName,
    this.rating, 
    this.totalReviews, 
    this.description,
    this.onTap
  });

  final String? title;
  final String? image;
  final String? userName;
  final double? rating;
  final int? totalReviews;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: config.sh(80),
            width: config.sw(90),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image!
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
                  "$title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextSizes.s14.copyWith(
                    fontSize: config.sp(15),
                    // decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const YMargin(5),
                Row(
                  children: [
                    Text(
                      "$userName  ",
                      style: TextSizes.s14.copyWith(
                        color: Colors.grey,
                        fontSize: config.sp(13)
                      ),
                    ),
                    RatingBarIndicator(
                      rating: rating ?? 0,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star, 
                        color: Colors.orange
                      ),
                      itemCount: 5,
                      itemSize: 15,
                      direction: Axis.horizontal,
                    ),
                    const XMargin(5),
                    Text(
                      "($totalReviews)",
                      style: TextSizes.s14,
                    )
                  ],
                ),
                const YMargin(5),
                Text(
                  "${description?.trim().replaceAll("\n", "")}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextSizes.s14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}