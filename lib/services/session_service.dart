import 'package:beanfast_customer/models/session.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class SessionService {
  final String baseUrl = 'Sessions';
  // final ApiService apiService = getx.Get.put(ApiService());

  Future<List<Session>> getSessionsBySchoolId(
      String schoolId, DateTime dateTime) async {
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    final response = await apiService.request.get(baseUrl,
        queryParameters: Map.from(
            {"SchoolId": schoolId, "DeliveryTime": date, 'Orderable': true}));
    List<Session> list = [];
    for (var e in response.data['data']) {
      list.add(Session.fromJson(e));
    }
    return list;
  }

  Future<Session> getById(String id) async {
    final response = await apiService.request.get('$baseUrl/$id');
    return Session.fromJson(response.data['data']);
  }

  Future<bool> checkCartItem(
      String profileId, String sessionId, String menuDetailId) async {
    Response response = await apiService.request
        .get('$baseUrl/$sessionId/check/$profileId/$menuDetailId');
    return response.data['data'];
  }
}
