import 'package:dio/dio.dart';

import '../utils/constants.dart';
import '/models/profile.dart';

class ProfileService {
  final String baseUrl = 'profiles';
  // final ApiService apiService = getx.Get.put(ApiService());

  Future<List<Profile>> getAll() async {
    final response = await apiService.request.get(baseUrl);
    List<Profile> list = [];
    for (var e in response.data['data']) {
      list.add(Profile.fromJson(e));
    }
    return list;
  }

  Future<Profile> getById(String id) async {
    final response = await apiService.request.get('$baseUrl/$id');
    return Profile.fromJson(response.data['data']);
  }

  Future<Response> deleteById(String id) async {
    final response = await apiService.request.delete('$baseUrl/$id');
    return response;
  }

  Future<Response> create(Profile model) async {
    FormData formData = FormData.fromMap({
      'Bmi.Height': model.bmis!.last.height,
      'Bmi.Weight': model.bmis!.last.weight,
      'Bmi.Age': model.bmis!.last.age,
      'FullName': model.fullName,
      'Class': model.className,
      'Image': await MultipartFile.fromFile(model.avatarPath!,
          filename: 'uploadFile.jpg'),
      'Gender': model.gender,
      'NickName': model.nickName,
      'SchoolId': model.school!.id,
      'Dob': model.dob,
    });
    final response = await apiService.request.post(baseUrl, data: formData);
    return response;
  }

  Future<bool> update(Profile model, bool isUpdateImage) async {
    FormData formData = FormData.fromMap({
      'Bmi.Height': model.bmis!.last.height,
      'Bmi.Weight': model.bmis!.last.weight,
      'Bmi.Age': model.bmis!.last.age,
      'FullName': model.fullName,
      'Class': model.className,
      'Gender': model.gender,
      'NickName': model.nickName,
      'SchoolId': model.schoolId,
      'Dob': model.dob,
    });
    if (isUpdateImage) {
      formData.files.add(MapEntry(
        'Image',
        await MultipartFile.fromFile(model.avatarPath!,
            filename: 'uploadFile.jpg'),
      ));
    }
    final response =
        await apiService.request.put('$baseUrl/${model.id}', data: formData);
    return response.statusCode == 200;
  }
}
