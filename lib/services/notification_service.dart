import 'package:beanfast_customer/models/notification.dart';

import '../utils/constants.dart';

class NotificationService {
  final String baseUrl = 'notifications';

  // final ApiService apiService = getx.Get.put(ApiService());

  Future<List<Notification>> getPage(int page, int size) async {
    final response = await apiService.request
        .get(baseUrl, queryParameters: Map.from({"page": page, "size": size}));
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

  Future<int> countUnreadNotifications() async {
    final response = await apiService.request.get("$baseUrl/count/unread");
    return response.data['data'];
  }
}
