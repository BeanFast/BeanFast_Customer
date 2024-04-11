import 'package:beanfast_customer/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/contrains/theme_color.dart';
import '/enums/status_enum.dart';
import '/views/widgets/order_item_widget.dart';
import 'loading_screen.dart';

class OrderTabBarView extends GetView<OrderController> {
  final OrderStatus orderStatus;

  const OrderTabBarView({super.key, required this.orderStatus});
  @override
  Widget build(BuildContext context) {
      
      
    controller.orderStatus = orderStatus;
    return LoadingScreen(
      future: controller.getByStatus,
      child: Obx(
        () => controller.listData.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/order_image.png",
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  color: ThemeColor.bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Obx(
                          () => Column(
                            children: controller.listData.map((order) {
                              return OrderItem(order: order);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
