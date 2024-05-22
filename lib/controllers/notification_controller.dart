import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';

import '/models/notification.dart';
import '/services/notification_service.dart';

class NotificationController extends GetxController {
  PagingController<int, Notification> pagingController =
      PagingController(firstPageKey: 1);
  RxBool allDone = true.obs;
  List<Notification> notifications = [];

  Future<void> fetchData(int pageKey) async {
    try {
      final newData = await NotificationService().getPage(pageKey, 5);
      notifications.addAll(newData);
      if (allDone.value) {
        if (notifications.where((n) => n.readDate == null)
                          .isNotEmpty) {
          allDone.value = false;
        }
      }
      final isLastPage = newData.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void resetPagingController() {
    notifications.clear();
    pagingController.dispose();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) async {
      await fetchData(pageKey);
    });
  }

  Future<void> markAsRead() async {
    var result = await NotificationService().markAsRead(notifications
        .where((e) => e.readDate == null)
        .map((e) => e.id!)
        .toList());
    if (result) {
      resetPagingController();
      allDone.value = true;
    }
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) async {
      await fetchData(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
