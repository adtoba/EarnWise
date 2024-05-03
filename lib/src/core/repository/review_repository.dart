import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:earnwise/src/core/domain/response/review_response.dart';
import 'package:earnwise/src/core/exceptions/api_failure.dart';
import 'package:earnwise/src/core/services/http_service.dart';
import 'package:earnwise/src/utils/error_util.dart';

abstract class ReviewRepository {
  Future<Either<List<ReviewResponse>, ApiFailure>> getReviews({String? expertId});
  Future<Either<List<ReviewResponse>, ApiFailure>> getMyReviews();
}


class ReviewRepositoryImpl extends HttpService implements ReviewRepository {
  @override
  Future<Either<List<ReviewResponse>, ApiFailure>> getMyReviews() async {
    try {
      final res = await http.get("/review");
      List<ReviewResponse> reviews = List.from((res.data as List).map(
        (e) => ReviewResponse.fromJson(e)).toList()
      );

      return left(reviews);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<List<ReviewResponse>, ApiFailure>> getReviews({String? expertId}) async {
    try {
      final res = await http.get("/review/$expertId");
      List<ReviewResponse> reviews = List.from((res.data as List).map(
        (e) => ReviewResponse.fromJson(e)).toList()
      );

      return left(reviews);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

}