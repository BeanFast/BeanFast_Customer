import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/order_controller.dart';
import '/contains/theme_color.dart';
import 'loading_screen.dart';
import '/enums/status_enum.dart';
import '/views/widgets/order_item_widget.dart';

class OrderTabBarView extends GetView<OrderController> {
  final OrderStatus orderStatus;

  const OrderTabBarView({super.key, required this.orderStatus});
  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      future: () => controller.fetchData(orderStatus),
      messageNoData: 'Chưa có dữ liệu',
      child: SingleChildScrollView(
        child: Container(
          color: ThemeColor.bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Obx(
                  () => Column(
                    children: controller.dataList.map((order) {
                      return OrderItem(order: order);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
