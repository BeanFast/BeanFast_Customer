import 'package:beanfast_customer/models/notification.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/services/api_service.dart';

class NotificationService {
  final String baseUrl = 'notifications';

  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<NotificationModel>> getPage(int pageNum, int pageSize) async {
    final response = await _apiService.request.get('$baseUrl?page=1&size=100');
    Map<int, List<NotificationModel>> result = {};
    List<NotificationModel> notifications = [];
    if (response.statusCode == 200) {
      dynamic responseData = response.data['data'];
      for (var e in responseData["items"]) {
        // var tran = Transaction.fromJson(e);
        notifications.add(NotificationModel.fromJson(e));
      }
    }
    return notifications;
  }
}
