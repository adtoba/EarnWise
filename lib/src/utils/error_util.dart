import 'package:dio/dio.dart';

class ErrorUtil {
  static String getErrorMessage(DioException exception) {
    if(exception.type == DioExceptionType.badResponse) {
      var response = exception.response;

      if(response?.statusCode == 403) {
        return "Unauthorized";
      } else if(response?.statusCode == 500) {
        return "Server Error";
      }

      return exception.response?.data?["detail"] ?? exception.response?.data?['message'];
    } else if(exception.type == DioExceptionType.connectionTimeout) {
      return "Your request has timed out. Please try again!";
    } else if(exception.type == DioExceptionType.receiveTimeout) {
      return "Your request has timed out. Please try again!";
    } else if(exception.type == DioExceptionType.sendTimeout) {
      return "Your request has timed out. Please try again!";
    } else if(exception.type == DioExceptionType.cancel) {
      return "Your request was canceled!";
    } else if(exception.type == DioExceptionType.badCertificate) {
      return "Your request failed, please try again!";
    } else {
      return "Something went wrong";
    }
  }
}