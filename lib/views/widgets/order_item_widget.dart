import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/formater.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';
import '/views/screens/order_detail_screen.dart';
import '../../contains/theme_color.dart';
import 'text_order_status_widget.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          OrderDetailScreen(orderId: order.id!),
        );
      },
      child: Container(
        color: ThemeColor.itemColor,
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
                      style: Get.textTheme.titleSmall),
                  TextOrderStatus(
                    status: OrderStatus.fromInt(order.status!),
                  ),
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
                              style: Get.textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'x${order.orderDetails![0].quantity.toString()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodySmall,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                Formater.formatMoney(
                                    order.orderDetails![0].price.toString()),
                                maxLines: 1,
                                style: Get.textTheme.bodySmall!.copyWith(
                                  color: const Color.fromRGBO(240, 103, 24, 1),
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
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.orderDetails!.length} sản phẩm',
                    style: Get.textTheme.bodySmall,
                  ),
                  Row(
                    children: [
                      Text(
                        'Thành tiền ',
                        style: Get.textTheme.bodySmall,
                      ),
                      Text(
                        Formater.formatMoney(order.totalPrice.toString()),
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: const Color.fromRGBO(240, 103, 24, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Điểm tích luỹ',
                    style: Get.textTheme.bodySmall,
                  ),
                  Text(
                    '${order.rewardPoints} điểm',
                    style: Get.textTheme.bodySmall,
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
