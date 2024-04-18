import 'package:get/get.dart';

import '/models/notification.dart';
import '/services/notification_service.dart';

class NotificationController extends GetxController {
  RxBool allDone = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  Future<void> fetchData() async {
    try {
      notifications.value = await NotificationService().getPage(1, 100);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> markAsRead() async {}
}
