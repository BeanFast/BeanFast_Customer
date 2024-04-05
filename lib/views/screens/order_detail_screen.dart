import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/enums/status_enum.dart';
import '/models/order.dart';
import '/views/widgets/banner_order_status.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // call api a order
    Order order = Order();
    order.status = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerOrderStatus(status: OrderStatus.fromInt(order.status!)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the icon tap here
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          color: ThemeColor.bgColor,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 20),
                                      SizedBox(width: 8),
                                      Text('Địa chỉ nhận hàng',
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                  Text('Trường tiểu học ',
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text('Cổng số 1',
                                    style: TextStyle(
                                      fontSize: 14,
                                    )),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.local_shipping_outlined,
                                          size: 20),
                                      SizedBox(width: 8),
                                      Text('Thông tin vận chuyển',
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                  Text(
                                      DateFormat('hh:mm dd/MM/yyyy')
                                          .format(DateTime.now()),
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: ThemeColor.bgColor,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tên profile',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Column(
                                children: List.generate(
                                  2,
                                  (index) => Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              'https://via.placeholder.com/150',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  130,
                                              height: 80,
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Nước ngọt',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        // color: Color(0xFF26AA91),
                                                        fontSize: 14,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text('x1',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          // color: Color(0xFF26AA91),
                                                          fontSize: 14,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text('150.000 đ',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 14,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(thickness: 1),
                                    ],
                                  ),
                                ),
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('2 sản phẩm',
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Row(
                                    children: [
                                      Text('Thành tiền ',
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                      Text('30.000 đ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: ThemeColor.bgColor,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Mã đơn hàng',
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      DateFormat('#68686868')
                                          .format(DateTime.now()),
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Thời gian đặt hàng',
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      DateFormat('hh:mm dd/MM/yyyy')
                                          .format(DateTime.now()),
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
