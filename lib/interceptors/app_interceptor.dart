import 'package:dio/dio.dart';

// import 'package:get/get.dart' hide Response;

import '/controllers/auth_controller.dart';
import '/utils/logger.dart';

class AppInterceptor extends Interceptor with CacheManager {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = getToken();
    if (token != null) {
      //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      //   final expiryTimestamp = decodedToken["exp"];
      //   final currentTime = DateTime.now().millisecondsSinceEpoch;
      //   if (currentTime >= expiryTimestamp) {
      //     logger.e(currentTime >= expiryTimestamp);
      //       // removeToken();
      //     AuthController().changeAuthState(AuthState.unauthenticated);
      //     logger.e('onRequest');
      //     // return;
      options.headers['Authorization'] = 'Bearer $token';
    } else {}
    // }

    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('onResponse');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('onError - $err');

    if (err.response?.statusCode == 401) {
      logger.e('end - 401');
    }

    return super.onError(err, handler);
  }
}
