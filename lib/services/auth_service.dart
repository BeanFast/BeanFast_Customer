import 'package:beanfast_customer/models/user.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/services/api_service.dart';

class AuthService {
  final String baseUrl = 'auth';
  final ApiService _apiService = getx.Get.put(ApiService());
  Future<Response> login(String phone, String password) async {
    Map<String, dynamic> data = {
      'phone': phone,
      'password': password,
    };
    final response =
        await _apiService.request.post('$baseUrl/login', data: data);
    logger.i(response.statusCode);
    logger.i(response.data);
    return response;
  }

  Future<User> getUser() async {
    final response = await _apiService.request.get('$baseUrl/current');
    return User.fromJson(response.data['data']);
  }
}
