import 'package:beanfast_customer/models/menu.dart';
import 'package:beanfast_customer/models/session.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:get/get.dart' as getx;

import '../utils/logger.dart';
import '/services/api_service.dart';

class MenuService {
  final String baseUrl = 'menus';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Session>> getSessionsBySchoolId(String schoolId) async {
    // final response = await _apiService.request.get(baseUrl);
    // return Menu.fromJson(response.data['data'][0]);
    logger.e('getSessionsBySchoolId');
    List<Session> list = [];
    for (var e in dataSessionOfSchool['data']) {
      list.add(Session.fromJson(e));
    }

    return list;
  }

  // Future<Profile> getById(String id) async {
  //   final response = await _apiService.request.get('$baseUrl/$id');
  //   return Profile.fromJson(response.data['data']);
  // }
}
