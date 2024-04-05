import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/order_controller.dart';
import '/utils/formater.dart';
import '/views/screens/loading_screen.dart';
import '/views/widgets/banner_order_status.dart';
import '/contrains/theme_color.dart';
import '/enums/status_enum.dart';

class OrderDetailScreen extends GetView<OrderController> {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      future: () async {
        await controller.getById(orderId);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết đơn hàng'),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerOrderStatus(
                  order: controller.model.value,
                ),
                Container(
                  color: ThemeColor.itemColor,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      if (controller.model.value.deliveryDate != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.local_shipping_outlined, size: 20),
                                SizedBox(width: 8),
                                Text('Thông tin vận chuyển',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            Text(
                                DateFormat('hh:mm dd/MM/yy').format(
                                    controller.model.value.deliveryDate!),
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: ThemeColor.itemColor,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              controller.model.value.profile!.fullName
                                  .toString(),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: controller.model.value.orderDetails!
                            .map(
                              (e) => Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          e.food!.imagePath!,
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
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(e.food!.name.toString(),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text('x${e.quantity}',
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    Formater.formatMoney(
                                                        e.price.toString()),
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                            )
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${controller.model.value.orderDetails!.length.toString()} sản phẩm',
                              style: const TextStyle(
                                fontSize: 14,
                              )),
                          Row(
                            children: [
                              const Text('Thành tiền ',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Text(
                                  Formater.formatMoney(controller
                                      .model.value.totalPrice
                                      .toString()),
                                  style: const TextStyle(
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
                  color: ThemeColor.itemColor,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Mã đơn hàng',
                              style: TextStyle(fontSize: 14)),
                          Text('#${controller.model.value.code.toString()}',
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Thời gian đặt hàng',
                              style: TextStyle(fontSize: 14)),
                          Text(
                              DateFormat('hh:mm dd/MM/yy')
                                  .format(controller.model.value.paymentDate!),
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
