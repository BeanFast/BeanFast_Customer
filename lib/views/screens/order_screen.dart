import 'package:beanfast_customer/enums/status_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/order_controller.dart';
import 'order_tabview.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return Scaffold(
        appBar: AppBar(
          // title: const Text(
          //   'Đơn hàng',
          //   style: TextStyle(fontSize: 30),
          // ),
          actions: [
            TextButton(
              onPressed: () async {
                final DateTimeRange? pickedDateRange =
                    await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 5),
                  lastDate: DateTime.now(),
                  initialDateRange: controller.selectedDateRange.value,
                );

                if (pickedDateRange != null &&
                    pickedDateRange != controller.selectedDateRange.value) {
                  controller.selectedDateRange.value = pickedDateRange;
                }
              },
              child: Row(
                children: [
                  Obx(
                    () => Text(
                      ' ${DateFormat('dd/MM/yyyy').format(controller.selectedDateRange.value.start)}'
                      ' - ${DateFormat('dd/MM/yyyy').format(controller.selectedDateRange.value.end)}',
                      style: const TextStyle(
                          color: Color(0xFF26AA91), fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        ),
        body: const DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Đang chuẩn bị'),
                  Tab(text: 'Đang giao'),
                  Tab(text: 'Hoàn thành'),
                  Tab(text: 'Đã hủy'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OrderTabBarView(
                      orderStatus: OrderStatus.preparing,
                    ), // Đang chuẩn bị
                    OrderTabBarView(
                      orderStatus: OrderStatus.delivering,
                    ), // Đang giao
                    OrderTabBarView(
                      orderStatus: OrderStatus.completed,
                    ), // Hoàn thành
                    OrderTabBarView(
                      orderStatus: OrderStatus.cancelled,
                    ), // Đã hủy
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}