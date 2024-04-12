import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';
import '/models/order.dart';
import '/services/order_service.dart';

class OrderController extends GetxController {
  RxList<Order> listData = <Order>[].obs;
  Rx<Order> model = Order().obs;
  OrderStatus orderStatus = OrderStatus.preparing;
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

  Future getById(String id) async {
    try {
      model.value = await OrderService().getById(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getByStatus() async {
    try {
      listData.value = await OrderService().getByStatus(orderStatus);
      listData.sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));
    } catch (e) {
      throw Exception(e);
    }
  }
}
