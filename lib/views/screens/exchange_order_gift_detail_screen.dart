import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/controllers/exchange_gift_controller.dart';
import '/utils/constants.dart';
import '/views/widgets/banner_order_exchange_gift_status.dart';
import '/views/widgets/sbutton.dart';
import '/views/widgets/image_default.dart';
import '/contains/theme_color.dart';
import '/enums/status_enum.dart';
import '/utils/formater.dart';
import 'data_screen.dart';
import 'loading_screen.dart';

class OrderGiftDetailScreen extends GetView<ExchangeGiftController> {
  const OrderGiftDetailScreen({super.key, required this.orderGiftId});
  final String orderGiftId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: LoadingScreen(
        future: () => controller.getById(orderGiftId),
        child: Obx(
          () => DataScreen(
            hasData: controller.model.value != null,
            message: 'Chưa có dữ liệu',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BannerOrderExchangeGiftStatus(
                    exchangeGift: controller.model.value!,
                  ),
                  Container(
                    color: ThemeColor.itemColor,
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        // Get.to( () => OrderTimeline(
                        //   order: controller.model.value,
                        // ));
                      },
                      child: Container(
                        color: ThemeColor.itemColor,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Iconsax.location),
                              title: const Text('Địa chỉ nhận hàng'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.model.value!.sessionDetail!
                                      .location!.school!.name
                                      .toString()),
                                  Text(controller.model.value!.sessionDetail!
                                      .location!.name
                                      .toString()),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (controller.model.value!.sessionDetail!.session!
                                        .deliveryStartTime !=
                                    null &&
                                controller.model.value!.sessionDetail!.session!
                                        .deliveryEndTime !=
                                    null)
                              ListTile(
                                leading: const Icon(Iconsax.truck_time),
                                title: Text('Thời gian nhận hàng',
                                    style: Get.textTheme.bodyMedium),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Từ ${DateFormat('HH:mm').format(controller.model.value!.sessionDetail!.session!.deliveryStartTime!)} đến ${DateFormat('HH:mm, dd/MM/yy').format(controller.model.value!.sessionDetail!.session!.deliveryEndTime!)}",
                                        style: Get.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                          ],
                        ),
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
                            Text(currentProfile.value!.fullName.toString(),
                                style: Get.textTheme.titleSmall),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            SizedBox(
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomNetworkImage(
                                    controller.model.value!.gift!.imagePath!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: Get.width - 100,
                                    height: 80,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            controller.model.value!.gift!.name
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.bodyMedium),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('x1',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Get.textTheme.bodySmall),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            Formater.formatPoint(
                                              controller
                                                  .model.value!.points
                                                  .toString(),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.bodySmall!
                                                .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 26, 128, 30),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(thickness: 1, color: Colors.grey),
                          ],
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
                                  'Tổng ',
                                  style: Get.textTheme.bodySmall,
                                ),
                                Text(
                                  Formater.formatPoint(controller
                                      .model.value!.points
                                      .toString()),
                                  style: Get.textTheme.bodySmall!.copyWith(
                                    color:
                                        const Color.fromARGB(255, 26, 128, 30),
                                  ),
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
                            Text('Mã đơn hàng',
                                style: Get.textTheme.bodyMedium),
                            GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                    'Hệ thống', 'Đã sao chép mã đơn hàng',
                                    snackPosition: SnackPosition.TOP);
                                Clipboard.setData(ClipboardData(
                                    text: controller.model.value!.code
                                        .toString()));
                              },
                              child: Text(
                                  '#${controller.model.value!.code.toString()}',
                                  style: Get.textTheme.bodySmall),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Thời gian đặt hàng',
                                style: Get.textTheme.bodyMedium),
                            Text(
                                DateFormat('HH:mm dd/MM/yy').format(
                                    controller.model.value!.paymentDate!),
                                style: Get.textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  //cancel order
                  if (controller.model.value!.status ==
                          ExchangeGiftStatus.preparing.code ||
                      controller.model.value!.status ==
                          ExchangeGiftStatus.delivering.code)
                    Center(
                      child: SButton(
                        color: controller.model.value!.status ==
                                ExchangeGiftStatus.preparing.code
                            ? ThemeColor.itemColor
                            : ThemeColor.textButtonColor,
                        borderColor: ThemeColor.textButtonColor,
                        text: 'Huỷ đơn hàng',
                        textStyle: Get.textTheme.titleMedium!.copyWith(
                          color: controller.model.value!.status ==
                                  ExchangeGiftStatus.preparing.code
                              ? ThemeColor.textButtonColor
                              : ThemeColor.itemColor,
                        ),
                        onPressed: () {
                          if (controller.model.value!.status !=
                              ExchangeGiftStatus.preparing.code) {
                            showCancelOrderDeliveryDialog();
                          } else {
                            showCancelDialog();
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCancelOrderDeliveryDialog() {
    Get.dialog(
      AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: ThemeColor.itemColor,
        title: const Text('Xác nhận'),
        content: SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng của bạn: ${ExchangeGiftStatus.fromInt(controller.model.value!.status!).message}',
                style: Get.textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Bạn sẽ không đươc hoàn lại số tiền đã thanh toán với đơn hàng ở trạng thái này.',
                style: Get.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              showCancelDialog();
            },
            child: Text('Huỷ đơn hàng',
                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Đóng',
                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void showCancelDialog() {
    controller.otherReasonController.clear();
    controller.handleRadioValueChanged(-1); //reset
    Get.dialog(
      AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: ThemeColor.itemColor,
        title: const Text('Lý do bạn muốn huỷ đơn hàng?'),
        content: SizedBox(
          // height: Get.height / 2,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var option in cancelExchangeGiftReasonOptions)
                  Obx(
                    () => RadioListTile<int>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(option['title'] as String),
                      value: option['value'] as int,
                      groupValue: controller.selectedValue.value,
                      onChanged: controller.handleRadioValueChanged,
                    ),
                  ),
                Obx(
                  () => controller.selectedValue.value == 3
                      ? TextField(
                          controller: controller.otherReasonController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              await controller
                  .cancelExchangeGift(controller.model.value!.id.toString());
            },
            child: Text('Huỷ đơn hàng',
                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
