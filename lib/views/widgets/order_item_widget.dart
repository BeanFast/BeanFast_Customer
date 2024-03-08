import 'package:beanfast_customer/enums/status_enum.dart';
import 'package:beanfast_customer/models/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contrains/theme_color.dart';
import 'text_order_status_widget.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.snackbar("Order Id 1", "1", snackPosition: SnackPosition.TOP);
      },
      child: Container(
        color:ThemeColor.bgColor,
        margin: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('6/1/2024',
                      style: TextStyle(
                        // color: Color(0xFF26AA91),
                        fontSize: 14,
                      )),
                  TextOrderStatus(status: OrderStatus.completed),
                ],
              ),
              const SizedBox(height: 5),
              const Text('Tên profile A',
                  style: TextStyle(
                    // color: Color(0xFF26AA91),
                    fontSize: 18,
                  )),
              const SizedBox(height: 5),
              SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://via.placeholder.com/150',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 130,
                      height: 80,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nước ngọt',
                              maxLines: 1,
                              style: TextStyle(
                                // color: Color(0xFF26AA91),
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('x1',
                                maxLines: 1,
                                style: TextStyle(
                                  // color: Color(0xFF26AA91),
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('150.000 đ',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                        ],
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
                        color: Color(0xFF26AA91),
                        fontSize: 14,
                      )),
                  Row(
                    children: [
                      Text('Thành tiền ',
                          style: TextStyle(
                            // color: Color(0xFF26AA91),
                            fontSize: 14,
                          )),
                      Text('300.000 đ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Điểm tích luỹ',
                      style: TextStyle(
                        // color: Color(0xFF26AA91),
                        fontSize: 14,
                      )),
                  Text('100 điểm',
                      style: TextStyle(
                        // color: Color(0xFF26AA91),
                        fontSize: 14,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
