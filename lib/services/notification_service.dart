import 'package:beanfast_customer/models/notification.dart';

import '../utils/constants.dart';

class NotificationService {
  final String baseUrl = 'notifications';

  // final ApiService apiService = getx.Get.put(ApiService());

  Future<List<Notification>> getPage(int pageNum, int pageSize) async {
    final response = await apiService.request.get('$baseUrl?page=1&size=100');
    List<Notification> notifications = [];
    if (response.statusCode == 200) {
      for (var e in response.data['data']["items"]) {
        notifications.add(Notification.fromJson(e));
      }
    }
    return notifications;
  }

  Future markAsRead(List<String> ids) async {
    Map<String, dynamic> data = {
      'NotificationIds': ids,
    };
    final response = await apiService.request.put(baseUrl, data: data);
    return response.statusCode == 200;
  }
}
