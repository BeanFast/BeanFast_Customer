import 'package:beanfast_customer/models/session.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';

import '/services/api_service.dart';

class SessionService {
  final String baseUrl = 'Sessions';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Session>> getSessionsBySchoolId(
      String schoolId, DateTime dateTime) async {
    String date = DateFormat('dd-MM-yyyy').format(dateTime);
    final response = await _apiService.request
        .get('$baseUrl?SchoolId=$schoolId&OrderTime=$date');
    List<Session> list = [];
    for (var e in response.data['data']) {
      list.add(Session.fromJson(e));
    }
    return list;
  }

  Future<Session> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return Session.fromJson(response.data['data']);
  }
}
