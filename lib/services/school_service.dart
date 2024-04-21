import 'package:get/get.dart' as getx;

import '/models/school.dart';
import '/services/api_service.dart';

class SchoolService {
  final String baseUrl = 'schools';
  final ApiService _apiService = getx.Get.put(ApiService());

  // Future<List<School>> getSchoolsBySchoolId(

  //   for (var e in response.data['data']) {
  //     list.add(School.fromJson(e));
  //   }
  //   return list;
  // }

  Future<List<School>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<School> list = [];
    for (var e in response.data['data']) {
      list.add(School.fromJson(e));
    }
    return list;
  }

  Future<School> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return School.fromJson(response.data['data']);
  }
}
