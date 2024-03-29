import 'package:beanfast_customer/models/user.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/services/api_service.dart';

class AuthService {
  final String baseUrl = 'auth';
  final ApiService _apiService = getx.Get.put(ApiService());
  Future<Response> login(String phone, String password) async {
    try {
      Map<String, dynamic> data = {
        'phone': '0372266084',
        'password': '12345678',
      };
      final response =
          await _apiService.request.post('$baseUrl/login', data: data);
      logger.i(response.statusCode);
      logger.i(response.data);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User> getUser() async {
    final response = await _apiService.request.get('$baseUrl/current');
    return User.fromJson(response.data['data']);
  }
}
