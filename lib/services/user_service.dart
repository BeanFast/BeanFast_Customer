import 'package:dio/dio.dart';

import '../utils/constants.dart';
import '/models/user.dart';
import '/models/qrcode.dart';

class UserService {
  final String baseUrl = 'users';
  // final ApiService apiService = getx.Get.put(ApiService());

  Future<UserQrCode> updateQRCode() async {
    final response = await apiService.request.put('$baseUrl/qrCode');
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
    final response = await apiService.request.put(baseUrl, data: formData);
    return response.statusCode == 200;
  }
}
