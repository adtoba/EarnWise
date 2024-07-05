import 'package:earnwise/src/core/domain/dto/create_review_request.dart';
import 'package:earnwise/src/core/domain/response/review_response.dart';
import 'package:earnwise/src/core/repository/review_repository.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/toast_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewViewModel = ChangeNotifierProvider((ref) {
  return ReviewViewModel(ReviewRepositoryImpl());
});

class ReviewViewModel extends ChangeNotifier {
  late ReviewRepository reviewRepository;

  ReviewViewModel(this.reviewRepository);

  bool isLoading = false;

  List<ReviewResponse> myReviews = [];

  void createReview(CreateReviewRequest request) async {
    isLoading = true;
    notifyListeners();

    final res = await reviewRepository.createReview(request);

    res.fold(
      (success) async {
        isLoading = false;
        notifyListeners();
        pop();
      },
      (failure) {
        isLoading = false;
        notifyListeners();

        ToastUtil.showError(message: failure.message);
      }
    );
  }

  Future<List<ReviewResponse>?> getMyReviews() async {
    final res = await reviewRepository.getMyReviews();

    return res.fold(
      (success) {
        myReviews = success;

        return success;

        // isLoading = false;
        // notifyListeners();
        
      },
      (failure) {
        // isLoading = false;
        // notifyListeners();

        ToastUtil.showError(message: failure.message);
        return null;
      }
    );
  }

  Future<List<ReviewResponse>?> getUserReviews({String? expertId}) async {

    final res = await reviewRepository.getReviews(expertId: expertId);

    return res.fold(
      (success) {
        return success;
      },
      (failure) {
        ToastUtil.showError(message: failure.message);
        return null;
      }
    );
  }
}