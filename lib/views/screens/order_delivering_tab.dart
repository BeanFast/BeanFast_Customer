import 'package:beanfast_customer/models/order.dart';
import 'package:beanfast_customer/views/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDeliveringTab extends StatelessWidget {
  const OrderDeliveringTab({super.key});

  @override
  Widget build(BuildContext context) {
    Order order = Order();
    return 
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              // OrderItem(order: order, index: 0),
              // OrderItem(order: order, index: 1),
              // OrderItem(order: order, index: 2),
              // OrderItem(order: order, index: 3),
              // OrderItem(order: order, index: 4),
            ]),
          )
        ],
      ),
    );
  }
}
