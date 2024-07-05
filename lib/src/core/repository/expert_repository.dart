import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:earnwise/src/core/domain/dto/create_expert_profile_request.dart';
import 'package:earnwise/src/core/exceptions/api_failure.dart';
import 'package:earnwise/src/core/services/http_service.dart';
import 'package:earnwise/src/utils/error_util.dart';

abstract class ExpertRepository {
  Future<Either<Map<String, dynamic>, ApiFailure>> createExpertProfile(CreateExpertProfileRequest request);
  Future<Either<Map<String, dynamic>, ApiFailure>> getExpertProfile({String? userId});
  Future<Either<Map<String, dynamic>, ApiFailure>> getExpertProfiles({String? filterBy, String? filterByValue});
  Future<Either<List<dynamic>, ApiFailure>> getSuggestedExpertProfiles();
}


class ExpertRepositoryImpl extends HttpService implements ExpertRepository {
  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> createExpertProfile(CreateExpertProfileRequest request) async {
    try {
      final res = await http.post("/expert", data: request.toJson());

      return left(res.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> getExpertProfile({String? userId}) async {
    try {
      final res = await http.get("/expert", queryParameters: {
        "user_id": userId
      });

      return left(res.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> getExpertProfiles({String? filterBy, String? filterByValue}) async {
    try {
      final res = await http.get("/expert/all", queryParameters: {
        "filter_by": filterBy,
        "filter_by_value": filterByValue
      });

      return left(res.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<List<dynamic>, ApiFailure>> getSuggestedExpertProfiles() async {
    try {
      final res = await http.get("/expert/explore");

      return left(res.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

}