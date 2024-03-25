import 'package:beanfast_customer/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/logger.dart';
import '/contrains/theme_color.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';
import '/views/widgets/order_item_widget.dart';
import 'loading_screen.dart';

class OrderTabBarView extends GetView<OrderController> {
  final OrderStatus orderStatus;
  const OrderTabBarView({super.key, required this.orderStatus});
  @override
  Widget build(BuildContext context) {
    controller.orderStatus = orderStatus;
    return LoadingScreen(
        future: controller.getData,
        child: Obx(() => controller.listData.isEmpty
            ? Column(
                children: [
                  Text(controller.statusCode.value),
                  Image.asset(
                    "assets/images/image_icon_order.jpg",
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Container(
                  color: ThemeColor.bgColor1,
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
                      )
                    ],
                  ),
                ),
              )));
  }
}


