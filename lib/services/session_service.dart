import 'package:beanfast_customer/models/session.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';

import '../utils/logger.dart';
import '/services/api_service.dart';

class SessionService {
  final String baseUrl = 'Sessions';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Session>> getSessionsBySchoolId(
      String schoolId, DateTime dateTime) async {
    logger.e('getSessionsBySchoolId');
    String date = DateFormat('dd-MM-yyyy').format(dateTime);
    logger.e(date);
    // final response = await _apiService.request
    //     .get('$baseUrl?SchoolId=$schoolId&OrderStartTime=$date');
    // // return Menu.fromJson(response.data['data'][0]);
    // logger.e(response.data['data']);
    List<Session> list = [];
    for (var e in dataSessionOfSchool['data']) {
      list.add(Session.fromJson(e));
    }
    return list;
  }

  Future<Session> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return Session.fromJson(response.data['data']);
  }
}
