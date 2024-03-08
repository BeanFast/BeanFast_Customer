import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/models/order.dart';
import 'package:beanfast_customer/views/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPreparingTab extends StatelessWidget {
  const OrderPreparingTab({super.key});

  @override
  Widget build(BuildContext context) {
    Order order = Order();
    return 
    SingleChildScrollView(
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
