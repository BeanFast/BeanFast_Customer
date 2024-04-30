import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/enums/status_enum.dart';
import '/controllers/order_controller.dart';
import 'order_tabview.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Lịch sử đơn hàng',
          ),
          actions: [
            // GestureDetector(
            //   onTap: () async {
            //     final DateTimeRange? pickedDateRange =
            //         await showDateRangePicker(
            //       context: context,
            //       locale: const Locale("vi", "VI"),
            //       firstDate: DateTime.now().subtract(const Duration(days: 180)),
            //       lastDate: DateTime.now(),
            //       initialDateRange: controller.selectedDateRange.value,
            //     );

            //     if (pickedDateRange != null &&
            //         pickedDateRange != controller.selectedDateRange.value) {
            //       controller.selectedDateRange.value = pickedDateRange;
            //     }
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.only(right: 10),
            //     padding: const EdgeInsets.only(
            //         right: 10, top: 10, bottom: 10, left: 10),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 0.8),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const Icon(Iconsax.calendar_search,
            //             size: 20, color: Colors.black),
            //         Obx(
            //           () => Text(
            //             ' ${DateFormat('dd/MM/yy').format(controller.selectedDateRange.value.start)}'
            //             ' - ${DateFormat('dd/MM/yy').format(controller.selectedDateRange.value.end)}',
            //             style: Get.textTheme.labelLarge!
            //                 .copyWith(color: Colors.black, fontSize: 13),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          
          ],
        ),
        body: const DefaultTabController(
          length: 4,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
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
