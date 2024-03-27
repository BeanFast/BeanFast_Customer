import 'package:beanfast_customer/models/menu.dart';
import 'package:get/get.dart' as getx;

import '../utils/logger.dart';
import '/services/api_service.dart';

class MenuService {
  final String baseUrl = 'menus';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<Menu> getBySchoolId(String schoolId) async {
    final response = await _apiService.request.get(baseUrl);
    return Menu.fromJson(response.data['data'][0]);
  }

  // Future<Profile> getById(String id) async {
  //   final response = await _apiService.request.get('$baseUrl/$id');
  //   return Profile.fromJson(response.data['data']);
  // }
}
