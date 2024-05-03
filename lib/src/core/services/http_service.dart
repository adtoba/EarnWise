import 'package:dio/dio.dart';
import 'package:earnwise/src/core/constants/prefs.dart';
import 'package:earnwise/src/core/services/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  late Dio http;
  HttpService() {
    http = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.105:8080/api/v1",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "content-type": "application/json"
        }
      )
    )..interceptors.add(
      QueuedInterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
        onRequest: (options, handler) async {
          String? userToken = await LocalStorage.get(SharedPrefs.userToken);
          
          options.headers.addAll({
            "Authorization": "Bearer $userToken"
          });

          return handler.next(options);
        }
      )
    )..transformer = BackgroundTransformer();

    http.interceptors.add(PrettyDioLogger(
      request: true,
      responseBody: true,
      error: true
    ));
  }
}