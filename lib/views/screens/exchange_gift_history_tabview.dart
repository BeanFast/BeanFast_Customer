import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/widgets/exchange_gift_item_widget.dart';
import '/controllers/exchange_gift_controller.dart';
import '/contains/theme_color.dart';
import '/enums/status_enum.dart';
import 'loading_screen.dart';

class ExchangeGiftHistoryTabBarView extends GetView<ExchangeGiftController> {
  final ExchangeGiftStatus exchangeGiftStatus;

  const ExchangeGiftHistoryTabBarView(
      {super.key, required this.exchangeGiftStatus});
  @override
  Widget build(BuildContext context) {
    controller.orderStatus = exchangeGiftStatus;
    return LoadingScreen(
      future: controller.getExchangeGiftByStatus,
      messageNoData: 'Chưa có lịch sử',
      child: SingleChildScrollView(
        child: Container(
          color: ThemeColor.bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Obx(
                  () => controller.listExchangeGiftData.isEmpty
                      ? SizedBox(
                          height: Get.height * 0.6,
                          child: Center(
                            child: Image.asset(
                              "assets/images/order_image.png",
                            ),
                          ),
                        )
                      : Column(
                          children: controller.listExchangeGiftData
                              .map((exchangeGift) {
                            return ExchangeGiftItem(exchangeGift: exchangeGift);
                          }).toList(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
