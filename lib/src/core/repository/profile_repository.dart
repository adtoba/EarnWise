import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:earnwise/src/core/domain/dto/update_profile_request.dart';
import 'package:earnwise/src/core/domain/response/get_profile_response.dart';
import 'package:earnwise/src/core/exceptions/api_failure.dart';
import 'package:earnwise/src/core/services/http_service.dart';
import 'package:earnwise/src/utils/error_util.dart';

abstract class ProfileRepository {
  Future<Either<Unit, ApiFailure>> updateProfile({required UpdateProfileRequest request});
  Future<Either<GetProfileResponse, ApiFailure>> getProfile();
}

class ProfileRepositoryImpl extends HttpService implements ProfileRepository {
  @override
  Future<Either<Unit, ApiFailure>> updateProfile({required UpdateProfileRequest request}) async {
    try {
      await http.put("/profile", data: request.toJson());
      return left(unit);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<GetProfileResponse, ApiFailure>> getProfile() async {
    try {
      final result = await http.get("/profile");

      return left(GetProfileResponse.fromJson(result.data));
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

}