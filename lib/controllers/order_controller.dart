
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString dropdownValue = 'Hoàn thành 1'.obs;

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 7)),
      end: DateTime.now(),
    ),
  );
  void updateStatus(String status) {
    dropdownValue.value = status;
  }
}