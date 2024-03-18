import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'order_delivering_tab.dart';
import 'order_preparing_tab.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());
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
                    pickedDateRange !=
                        controller.selectedDateRange.value) {
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
            // mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                isScrollable: true,
                // indicatorPadding: EdgeInsets.zero,
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
                    OrderPreparingTab(), // Đang chuẩn bị
                    OrderDeliveringTab(), // Đang giao
                    OrderCompletedTab(), // Hoàn thành
                    OrderCancelledTab(), // Đã hủy
                  ],
                ),
              ),
            ],
          ),
        )
        );
  }
}

class OrderCancelledTab extends StatelessWidget {
  const OrderCancelledTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('OrderCancelledTab'),
    );
  }
}

class OrderCompletedTab extends StatelessWidget {
  const OrderCompletedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('OrderCompletedTab'),
    );
  }
}

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
