import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/interceptors/app_interceptor.dart';

class ApiService extends getx.GetxService {
  // final String baseUrl;
  late Dio _dio;

  static BaseOptions options = BaseOptions(
    baseUrl: 'https://beanfast.id.vn/api/v1/',
    headers: {
      Headers.contentTypeHeader: "application/json",
      Headers.acceptHeader: "text/plain"
    },
    sendTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  // ApiService(){
  //   _dio = Dio(options);
  //   _dio.interceptors.add(AppInterceptor());
  // }

  Dio get request {
    return _dio;
  }

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(options);
    _dio.interceptors.add(AppInterceptor());
  }
}
