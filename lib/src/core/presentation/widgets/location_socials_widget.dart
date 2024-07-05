import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/extensions.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';


class LocationSocialsWidget extends StatelessWidget {
  const LocationSocialsWidget({
    super.key, 
    this.location,
    this.instagram,
    this.twitter,
    this.linkedin
  });
  
  final String? location;
  final String? instagram;
  final String? twitter;
  final String? linkedin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined),
        const XMargin(5),
        Text(
          "$location",
          style: TextSizes.s14.copyWith(
            fontWeight: FontWeight.w600
          ),
        ),
        const XMargin(10),
        Text(
          instagram != null || twitter != null || linkedin != null ? "\u2022" : "",
          style: TextSizes.s16.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
        const XMargin(10),
        if(instagram != null)...[
          ImageIcon(
            AssetImage(
              "instagram".png
            ),
            size: 20,
          ),
        ],
        
        if(twitter != null)...[
          const XMargin(10),
          ImageIcon(
            AssetImage(
              "twitter".png
            ),
            size: 20,
          ),
        ],

        if(linkedin != null)...[
          const XMargin(10),
          ImageIcon(
            AssetImage(
              "linkedin".png
            ),
            size: 20,
          ),
        ],
      ],
    );
  }
}