import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:earnwise/src/core/constants/prefs.dart';
import 'package:earnwise/src/core/exceptions/api_failure.dart';
import 'package:earnwise/src/core/services/http_service.dart';
import 'package:earnwise/src/core/services/storage_service.dart';
import 'package:earnwise/src/utils/error_util.dart';

abstract class AuthRepository {
  Future<Either<Map<String, dynamic>, ApiFailure>> login({required Map data});
  Future<Either<Map<String, dynamic>, ApiFailure>> register({required Map data});
}

class AuthRepositoryImpl extends HttpService implements AuthRepository {
  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> login({required Map data}) async {
    try {
      final result = await http.post("/user/login", data: data);
      await LocalStorage.put(SharedPrefs.userToken, result.data["token"]);
      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> register({required Map data}) async {
    try {
      final result = await http.post("/user/register", data: data);

      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

}