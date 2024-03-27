import 'dart:io';

import 'package:beanfast_customer/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../utils/logger.dart';
import '/services/api_service.dart';

class ProfileService {
  final String baseUrl = 'profiles';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Profile>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<Profile> list = [];
    for (var e in response.data['data']) {
      list.add(Profile.fromJson(e));
    }
    return list;
  }

  Future<Profile> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return Profile.fromJson(response.data['data']);
  }

  Future create(Profile model) async {
    File file = File('/path/to/your/file');

    FormData formData = FormData.fromMap({
      'Bmi.Height': model.bmis!.last.height,
      'Bmi.Weight': model.bmis!.last.weight,
      'Bmi.Age': model.bmis!.last.age,
      'FullName': model.fullName,
      'Class': model.className,
      'Image':
          await MultipartFile.fromFile(file.path, filename: 'uploadFile.jpg'),
      'Gender': model.gender,
      'NickName': model.nickName,
      'SchoolId': model.school!.id,
      'Dob': model.dob,
    });
    await _apiService.request.post(baseUrl, data: formData);
  }
}
