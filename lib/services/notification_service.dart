import 'package:beanfast_customer/models/notification.dart';
import 'package:get/get.dart' as getx;

import '/services/api_service.dart';

class NotificationService {
  final String baseUrl = 'notifications';

  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Notification>> getPage(int pageNum, int pageSize) async {
    final response = await _apiService.request.get('$baseUrl?page=1&size=100');
    List<Notification> notifications = [];
    if (response.statusCode == 200) {
      for (var e in response.data['data']["items"]) {
        notifications.add(Notification.fromJson(e));
      }
    }
    return notifications;
  }
}
