import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/screens/exchange_order_gift_detail_screen.dart';
import '/views/widgets/image_default.dart';
import '/contains/theme_color.dart';
import '/enums/status_enum.dart';
import '/models/exchange_gift.dart';
import '/utils/formater.dart';
import 'text_order_status_widget.dart';

class ExchangeGiftItem extends StatelessWidget {
  final ExchangeGift exchangeGift;
  const ExchangeGiftItem({super.key, required this.exchangeGift});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to( () =>OrderGiftDetailScreen(orderGiftId: exchangeGift.id!));
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
                  Expanded(
                    child: Text(
                      exchangeGift.profile!.fullName.toString(),
                      style: Get.textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: 90,
                    child: TextGiftOrderStatus(
                      status: ExchangeGiftStatus.fromInt(exchangeGift.status!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      exchangeGift.gift!.imagePath!,
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
                              exchangeGift.gift!.name!,
                              style: Get.textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'x1',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodySmall,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                Formater.formatPoint(
                                    exchangeGift.points.toString()),
                                maxLines: 1,
                                style: Get.textTheme.bodySmall!.copyWith(
                                  color: const Color.fromARGB(
                                                      255, 26, 128, 30),
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
                    '1 sản phẩm',
                    style: Get.textTheme.bodySmall,
                  ),
                  Row(
                    children: [
                      Text(
                        'Thành tiền ',
                        style: Get.textTheme.bodySmall,
                      ),
                      Text(
                        Formater.formatPoint(exchangeGift.points.toString()),
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(
                                                      255, 26, 128, 30),
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
