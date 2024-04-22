import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';
import '/models/order.dart';
import '/services/order_service.dart';

class OrderController extends GetxController {
  final RxInt _selectedValue = RxInt(-1);
  final RxString _otherReason = RxString('');

  int get selectedValue => _selectedValue.value;
  String get otherReason => _otherReason.value;

  void handleRadioValueChanged(int? value) {
    if (value != null) {
      _selectedValue.value = value;
      if (value != 3) {
        _otherReason.value = '';
      }
      update();
    }
  }

  void handleOtherReasonChanged(String reason) {
    _otherReason.value = reason;
    update();
  }

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
