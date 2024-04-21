import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/exchange_gift.dart';
import '/enums/status_enum.dart';
import '/contrains/theme_color.dart';
import 'text_order_status_widget.dart';
import '/utils/formater.dart';

class ExchangeGiftItem extends StatelessWidget {
  final ExchangeGift exchangeGift;
  const ExchangeGiftItem({super.key, required this.exchangeGift});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(OrderDetailScreen(orderId: order.id!));
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
                  Text(exchangeGift.profile!.fullName.toString(),
                      style: Get.textTheme.titleSmall),
                  TextOrderStatus(
                    status: OrderStatus.fromInt(exchangeGift.status!),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //   Image.network(
                    //     order.orderDetails![0].food!.imagePath.toString(),
                    //     width: 80,
                    //     height: Get.height,
                    //     fit: BoxFit.cover,
                    //   ),
                    //   Expanded(
                    //     child: Container(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             order.orderDetails![0].food!.name.toString(),
                    //             style: Get.textTheme.bodyLarge,
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //           ),
                    //           Align(
                    //             alignment: Alignment.centerRight,
                    //             child: Text(
                    //               'x${order.orderDetails![0].quantity.toString()}',
                    //               maxLines: 1,
                    //               overflow: TextOverflow.ellipsis,
                    //               style: Get.textTheme.bodySmall,
                    //             ),
                    //           ),
                    //           Align(
                    //             alignment: Alignment.centerRight,
                    //             child: Text(
                    //               Formater.formatMoney(
                    //                   order.orderDetails![0].price.toString()),
                    //               maxLines: 1,
                    //               style: Get.textTheme.bodySmall!.copyWith(
                    //                 color: const Color.fromRGBO(240, 103, 24, 1),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
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
                  // Text(
                  //   '${order.orderDetails!.length} sản phẩm',
                  //   style: Get.textTheme.bodySmall,
                  // ),
                  Row(
                    children: [
                      Text(
                        'Thành tiền ',
                        style: Get.textTheme.bodySmall,
                      ),
                      Text(
                        Formater.formatPoint(exchangeGift.points.toString()),
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: const Color.fromRGBO(240, 103, 24, 1),
                        ),
                      ),
                    ],
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
