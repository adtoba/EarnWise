import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:earnwise/src/core/domain/dto/create_call_request.dart';
import 'package:earnwise/src/core/exceptions/api_failure.dart';
import 'package:earnwise/src/core/services/http_service.dart';
import 'package:earnwise/src/utils/error_util.dart';

abstract class CallRepository {
  Future<Either<Map<String, dynamic>, ApiFailure>> createCall({CreateCallRequest? request});
  Future<Either<List<dynamic>, ApiFailure>> getUserCalls();
  Future<Either<Map<String, dynamic>, ApiFailure>> acceptCall({required String? callId});
  Future<Either<Map<String, dynamic>, ApiFailure>> declineCall({required String? callId, String? reason});
  Future<Either<Map<String, dynamic>, ApiFailure>> cancelCall({required String? callId, String? reason});
}

class CallRepositoryImpl extends HttpService implements CallRepository {
  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> createCall({CreateCallRequest? request}) async {
    try {
      final result = await http.post("/call", data: request?.toJson());
      
      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

   @override
  Future<Either<List<dynamic>, ApiFailure>> getUserCalls() async {
    try {
      final result = await http.get("/call");
      
      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> acceptCall({required String? callId}) async {
    try {
      final result = await http.put("/call/$callId/accept");

      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> declineCall({required String? callId, String? reason}) async {
    try {
      final result = await http.put("/call/$callId/decline", data: {
        "cancelReason": reason
      });

      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiFailure>> cancelCall({required String? callId, String? reason}) async {
    try {
      final result = await http.put("/call/$callId/cancel", data: {
        "cancelReason": reason
      });

      return left(result.data);
    } on DioException catch (e) {
      String message = ErrorUtil.getErrorMessage(e);
      return right(ApiFailure(message));
    }
  }

}