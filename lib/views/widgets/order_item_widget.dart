import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  const Text('Tên profile A',
                      style: TextStyle(
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
                      'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                      width: 80,
                      height: Get.height,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số',
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'x1',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '150.000 đ',
                                maxLines: 1,
                                style: TextStyle(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('2 sản phẩm',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  Row(
                    children: [
                      Text(
                        'Thành tiền ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '300.000 đ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Điểm tích luỹ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '100 điểm',
                    style: TextStyle(
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
