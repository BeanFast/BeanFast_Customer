import 'package:flutter/material.dart';

import '/contrains/theme_color.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';
import '/views/widgets/order_item_widget.dart';

class OrderTabBarView extends StatelessWidget {
  final OrderStatus orderStatus;
  const OrderTabBarView({super.key, required this.orderStatus});
  @override
  Widget build(BuildContext context) {
    // controller call api
    Order order = Order();

    switch (orderStatus) {
      case OrderStatus.preparing:
        order.status = 1;
        break;
      case OrderStatus.delivering:
        order.status = 2;
        break;
      case OrderStatus.completed:
        order.status = 3;
        break;
      case OrderStatus.cancelled:
        order.status = 4;
        break;
      default:
    }
    return SingleChildScrollView(
      child: Container(
        color: ThemeColor.bgColor1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(children: [
                OrderItem(order: order),
                OrderItem(order: order),
                OrderItem(order: order),
                OrderItem(order: order),
                OrderItem(order: order),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
