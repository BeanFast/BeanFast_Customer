import 'package:beanfast_customer/views/screens/order_time_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/contrains/theme_color.dart';
import '/controllers/order_controller.dart';
import '/utils/formater.dart';
import '/views/screens/loading_screen.dart';
import '/views/widgets/banner_order_status.dart';

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
                  child: GestureDetector(
                    onTap: () {
                      Get.to(OrderTimeline(
                        order: controller.model.value,
                      ));
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Iconsax.location, size: 20),
                                const SizedBox(width: 8),
                                Text('Địa chỉ nhận hàng',
                                    style: Get.textTheme.labelLarge),
                              ],
                            ),
                            Text('Trường tiểu học ',
                                style: Get.textTheme.bodySmall),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child:
                              Text('Cổng số 1', style: Get.textTheme.bodySmall),
                        ),
                        const SizedBox(height: 5),
                        if (controller.model.value.deliveryDate != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Iconsax.truck_fast, size: 20),
                                  const SizedBox(width: 8),
                                  Text('Thông tin vận chuyển',
                                      style: Get.textTheme.labelLarge),
                                ],
                              ),
                              Text(
                                  DateFormat('hh:mm dd/MM/yy').format(
                                      controller.model.value.deliveryDate!),
                                  style: Get.textTheme.bodySmall),
                            ],
                          ),
                      ],
                    ),
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
                              style: Get.textTheme.titleSmall),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      Get.textTheme.bodyMedium),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text('x${e.quantity}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Get
                                                        .textTheme.bodySmall),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    Formater.formatMoney(
                                                        e.price.toString()),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Get
                                                        .textTheme.bodySmall!
                                                        .copyWith(
                                                            color: Colors.red)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.grey),
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
                            style: Get.textTheme.bodySmall,
                          ),
                          Row(
                            children: [
                              Text(
                                'Thành tiền ',
                                style: Get.textTheme.bodySmall,
                              ),
                              Text(
                                Formater.formatMoney(controller
                                    .model.value.totalPrice
                                    .toString()),
                                style: Get.textTheme.bodySmall!
                                    .copyWith(color: Colors.red),
                              ),
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
                          Text('Mã đơn hàng', style: Get.textTheme.bodyMedium),
                          Text('#${controller.model.value.code.toString()}',
                              style: Get.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thời gian đặt hàng',
                              style: Get.textTheme.bodyMedium),
                          Text(
                              DateFormat('hh:mm dd/MM/yy')
                                  .format(controller.model.value.paymentDate!),
                              style: Get.textTheme.bodySmall),
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
