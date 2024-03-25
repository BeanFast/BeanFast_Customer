import 'package:beanfast_customer/enums/status_enum.dart';
import 'package:beanfast_customer/models/food.dart';
import 'package:beanfast_customer/models/order.dart';
import 'package:beanfast_customer/services/food_service.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/order_service.dart';

class OrderController extends GetxController {
  RxBool isError = false.obs;
  RxString statusCode = ''.obs;
  RxList<Order> listData = <Order>[].obs;
  OrderStatus orderStatus = OrderStatus.preparing;
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

  Future getData() async {
    logger.i('getData');
    try {
      var response = await OrderService().getByStatus(orderStatus);
      List<Order> list = [];
      for (var e in response.data['data']) {
        list.add(Order.fromJson(e));
        var order = list.last;
        var responseFood =
            await FoodService().getById(order.orderDetails![0].foodId!);
        order.orderDetails![0].food = Food.fromJson(responseFood.data['data']);
      }
      listData.value = list;
      statusCode.value = listData.length.toString();
    } catch (e) {
      isError.value = true;
    }
  }
}
