import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/user.dart';
import '/models/qrcode.dart';
import '/services/api_service.dart';

class UserService {
  final String baseUrl = 'users';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<UserQrCode> updateQRCode() async {
    final response = await _apiService.request.put('$baseUrl/qrCode');
    return UserQrCode.fromJson(response.data['data']);
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
