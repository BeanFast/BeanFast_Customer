import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/menu_index_enum.dart';
import '../views/screens/splash_screen.dart';
import '/utils/constants.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';
import '/services/order_service.dart';

class OrderController extends GetxController {
  OrderStatus orderStatus = OrderStatus.preparing;
  PagingController<int, Order> pagingController =
      PagingController(firstPageKey: 1);

  final RxInt selectedValue = RxInt(-1);
  final TextEditingController otherReasonController = TextEditingController();

  RxList<Order> dataList = <Order>[].obs;
  Rx<Order?> model = Rx<Order?>(null);
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString dropdownValue = 'Hoàn thành 1'.obs;

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
  );
  void updateStatus(String status) {
    dropdownValue.value = status;
  }

  void resetPagingController() {
    pagingController.dispose();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) async {
      await fetchData(pageKey);
    });
  }

  Future fetchData(int pageKey) async {
    try {
      var data = await OrderService().getByStatus(orderStatus, pageKey, 5);
      for (var e in data) {
        e.orderActivities!.sort((a, b) => b.time!.compareTo(a.time!));
      }
      data.sort((a, b) => b.orderActivities!.first.time!
          .compareTo(a.orderActivities!.first.time!));

      final isLastPage = data.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(data);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(data, nextPageKey);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getById(String id) async {
    model.value = null;
    try {
      model.value = await OrderService().getById(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  void handleRadioValueChanged(int? value) {
    if (value != null) {
      selectedValue.value = value;
    }
  }

  Future cancelOrder(String id) async {
    if (selectedValue.value == -1) {
      Get.snackbar('Thông báo', 'Vui lòng nhập lý do');
    } else if (selectedValue.value == 3 && otherReasonController.text.isEmpty) {
      Get.snackbar('Hệ thống', 'Vui lòng nhập lý do huỷ',
          duration: const Duration(seconds: 1));
    } else {
      String reason;
      if (selectedValue.value != 3) {
        reason =
            cancelOrderReasonOptions[selectedValue.value]['title'] as String;
      } else {
        reason = otherReasonController.text;
      }
      //call api
      try {
        await OrderService().cancelOrder(id, reason);
        Get.snackbar('Hệ thống', 'Huỷ đơn hàng thành công');
        changePage(MenuIndexState.order.index);
        Get.offAll(const SplashScreen());
      } on DioException catch (e) {
        Get.snackbar('Lỗi', e.response!.data['message']);
      }
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
