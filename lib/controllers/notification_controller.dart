import 'package:get/get.dart';

import '/models/notification.dart';
import '/services/notification_service.dart';

class NotificationController extends GetxController {
  RxBool allDone = false.obs;
  RxList<Notification> notifications = <Notification>[].obs;
  Future<void> fetchData() async {
    try {
      notifications.value = await NotificationService().getPage(1, 100);
      notifications.sort((a, b) => b.sendDate!.compareTo(a.sendDate!));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> markAsRead() async {
    var result = await NotificationService().markAsRead(notifications
        .where((e) => e.readDate == null)
        .map((e) => e.id!)
        .toList());
    if (result) {
      await fetchData();
      allDone.value = true;
    }
  }
}
