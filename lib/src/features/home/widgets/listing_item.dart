import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';

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
  final String? rating;
  final String? totalReviews;
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
                image: AssetImage(
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
                      style: TextSizes.s12.copyWith(
                        color: Colors.grey,
                        fontSize: config.sp(13)
                      ),
                    ),
                    const Icon(Icons.star, color: Colors.orange, size: 15,),
                    const Icon(Icons.star, color: Colors.orange, size: 15,),
                    const Icon(Icons.star, color: Colors.orange, size: 15,),
                    const Icon(Icons.star, color: Colors.orange, size: 15,),
                    const Icon(Icons.star, color: Colors.grey, size: 15,),
                    Text(
                      "  ($totalReviews) ",
                      style: TextSizes.s12.copyWith(
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
                const YMargin(5),
                Text(
                  "$description",
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
  }
}