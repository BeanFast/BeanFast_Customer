import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/formater.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';
import '/views/screens/order_detail_screen.dart';
import '/contrains/theme_color.dart';
import 'text_order_status_widget.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(const OrderDetailScreen());
      },
      child: Container(
        color: ThemeColor.bgColor,
        margin: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.profile!.fullName.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                  TextOrderStatus(status: OrderStatus.fromInt(order.status!)),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      order.orderDetails![0].food!.imagePath.toString(),
                      width: 80,
                      height: Get.height,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.orderDetails![0].food!.name.toString(),
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'x${order.orderDetails![0].quantity.toString()}',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                Formater.formatMoney(
                                    order.orderDetails![0].price.toString()),
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${order.orderDetails!.length} sản phẩm',
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                  Row(
                    children: [
                      const Text(
                        'Thành tiền ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        Formater.formatMoney(order.totalPrice.toString()),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Điểm tích luỹ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    order.rewardPoints.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
