import 'package:earnwise/src/core/domain/response/review_response.dart';
import 'package:earnwise/src/core/presentation/widgets/review_widget.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';

class AllReviewPage extends StatelessWidget {
  const AllReviewPage({super.key, this.reviews});

  final List<ReviewResponse>? reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 1,
        // title: Text(
        //   "Reviews",
        //   style: TextStyle(
        //     fontSize: config.sp(22),
        //     fontFamily: GoogleFonts.raleway().fontFamily,
        //     fontWeight: FontWeight.bold
        //   ),
        // ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: config.sh(20), horizontal: config.sw(20)),
        itemBuilder: (c, i) {
          var review = reviews![i];
          return ReviewWidget(review: review);
        }, 
        separatorBuilder: (c, i) => Divider(height: config.sh(20)), 
        itemCount: reviews!.length
      ),
    );
  }
}