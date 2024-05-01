import 'package:get/get.dart' as getx;

import '/models/qrcode.dart';
import '/services/api_service.dart';

class UserService {
  final String baseUrl = 'users';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<UserQrCode> updateQRCode() async {
    final response = await _apiService.request.put('$baseUrl/qrCode');
    return UserQrCode.fromJson(response.data['data']);
  }
}
