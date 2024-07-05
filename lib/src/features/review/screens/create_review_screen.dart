import 'package:earnwise/src/core/domain/dto/create_review_request.dart';
import 'package:earnwise/src/core/domain/response/get_profile_response.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/home/widgets/primary_loading_indicator.dart';
import 'package:earnwise/src/features/review/view_model/review_vm.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';


class CreateReviewScreen extends ConsumerStatefulWidget {
  const CreateReviewScreen({super.key, this.userProfile, this.expertId});

  final GetProfileResponse? userProfile;
  final String? expertId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends ConsumerState<CreateReviewScreen> {

  double rating = 0.0;

  final formKey = GlobalKey<FormState>();
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var reviewProvider = ref.watch(reviewViewModel);

    return LoadingOverlay(
      isLoading: reviewProvider.isLoading,
      progressIndicator: const PrimaryLoadingIndicator(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: false,
          elevation: 1,
          title: Text(
            "Review",
            style: TextStyle(
              fontSize: config.sp(22),
              fontFamily: GoogleFonts.raleway().fontFamily,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RatingBar.builder(
                    initialRating: 0,
                    allowHalfRating: true,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) {
                      return const Icon(
                        Icons.star,
                        color: Colors.orange,
                      );
                    }, 
                    onRatingUpdate: (val) {
                      setState(() {
                        rating = val;
                      });
                    }
                  ),
                ),
                const YMargin(30),
                AppTextField(
                  controller: reviewController,
                  maxLines: 7,
                  hint: "Write a review",
                  validator: Validators.validateField,
                ),
                const YMargin(30),
                AppButton(
                  text: "Submit",
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      reviewProvider.createReview(CreateReviewRequest(
                        review: reviewController.text,
                        rating: rating,
                        expertId: widget.expertId,
                        expertProfilePic: widget.userProfile?.profilePic, 
                      ));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}