import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/qrcode.dart';
import '/services/api_service.dart';
import '/models/user.dart';
import '/utils/logger.dart';

class AuthService {
  final String baseUrl = 'auth';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<Response> login(
      String phone, String password, String deviceToken) async {
    Map<String, dynamic> data = {
      'phone': phone,
      'password': password,
      'deviceToken': deviceToken,
    };
    final response =
        await _apiService.request.post('$baseUrl/login', data: data);
    logger.i(response.statusCode);
    logger.i(response.data);
    return response;
  }

  Future register(String phone, String password) async {
    Map<String, dynamic> data = {
      'phone': phone,
      'password': password,
    };
    final response = await _apiService.request
        .post('$baseUrl/register', data: FormData.fromMap(data));
    logger.i(response.statusCode);
    logger.i(response.data);
    return response;
  }

  Future sendOtp(String phone) async {
    Map<String, dynamic> data = {
      'phone': phone,
    };
    final response = await _apiService.request.post('$baseUrl/otp', data: data);
    logger.i(response.statusCode);
    logger.i(response.data);
    return response;
  }

  Future verifyOtp(String phone, String otpValue) async {
    Map<String, dynamic> data = {
      'phone': phone,
      'otpValue': otpValue,
    };
    final response =
        await _apiService.request.post('$baseUrl/otp/verify', data: data);
    logger.i(response.statusCode);
    logger.i(response.data);
    return response;
  }

  Future<User> getUser() async {
    final response = await _apiService.request.get('$baseUrl/current');
    return User.fromJson(response.data['data']);
  }

  Future<bool> updateUser(User model) async {
    FormData formData = FormData.fromMap({
      'FullName': model.fullName,
    });
    if (model.avatarPath != null) {
      formData.files.add(MapEntry(
        'Image',
        await MultipartFile.fromFile(model.avatarPath!,
            filename: 'uploadFile.jpg'),
      ));
    }
    final response = await _apiService.request.put(baseUrl, data: formData);
    return response.statusCode == 200;
  }
}
