import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/enums/status_enum.dart';
import '/views/screens/order_time_line.dart';
import '/views/screens/welcome_screen.dart';
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
                    child: Container(
                      color: ThemeColor.itemColor,
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
                            child: Text('Cổng số 1',
                                style: Get.textTheme.bodySmall),
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
                                                            color: const Color
                                                                .fromRGBO(240,
                                                                103, 24, 1))),
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
                                style: Get.textTheme.bodySmall!.copyWith(
                                    color:
                                        const Color.fromRGBO(240, 103, 24, 1)),
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
                          GestureDetector(
                            onTap: () {
                              Get.snackbar(
                                  'Hệ thống', 'Đã sao chép mã đơn hàng',
                                  snackPosition: SnackPosition.TOP);
                              Clipboard.setData(ClipboardData(
                                  text:
                                      controller.model.value.code.toString()));
                            },
                            child: Text(
                                '#${controller.model.value.code.toString()}',
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
                              DateFormat('hh:mm dd/MM/yy')
                                  .format(controller.model.value.paymentDate!),
                              style: Get.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                //cancel order
                if (controller.model.value.status !=
                        OrderStatus.completed.code &&
                    controller.model.value.status != OrderStatus.cancelled.code)
                  Center(
                    child: SButton(
                      color: controller.model.value.status ==
                              OrderStatus.preparing.code
                          ? ThemeColor.itemColor
                          : ThemeColor.textButtonColor,
                      borderColor: ThemeColor.textButtonColor,
                      text: 'Huỷ đơn hàng',
                      textStyle: Get.textTheme.titleMedium!.copyWith(
                        color: controller.model.value.status ==
                                OrderStatus.preparing.code
                            ? ThemeColor.textButtonColor
                            : ThemeColor.itemColor,
                      ),
                      onPressed: () {
                        // Check if order is not preparing
                        // Đang set == preparing.code sai để test giao diện đúng thì != preparing.code
                        if (controller.model.value.status ==
                            OrderStatus.preparing.code) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    'Bạn có chắc chắn muốn huỷ đơn hàng?'),
                                content: SizedBox(
                                  height: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Đơn hàng của bạn: ${OrderStatus.fromInt(controller.model.value.status! + 1).message}',
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
                                      Get.back(); // Close the confirmation dialog
                                      // Show the cancellation dialog
                                      //initially set selected value to -1
                                      controller.handleRadioValueChanged(-1);
                                      // Show dialog
                                      showCancelDialog(controller, context);
                                    },
                                    child: const Text('Xác nhận huỷ đơn hàng'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back(); // Close the confirmation dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          //initially set selected value to -1
                          controller.handleRadioValueChanged(-1);
                          // Show dialog
                          showCancelDialog(controller, context);
                        }
                      },
                    ),
                  ),
                //feedback
                if (controller.model.value.status == OrderStatus.completed.code)
                  Center(
                    child: SButton(
                      color: ThemeColor.textButtonColor,
                      borderColor: ThemeColor.textButtonColor,
                      text: 'Đánh giá đơn hàng',
                      textStyle: Get.textTheme.titleMedium!.copyWith(
                        color: ThemeColor.itemColor,
                      ),
                      onPressed: () {
                        showFeedbackDialog(controller, context);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CancellationReason {
  final String title;
  final int value;

  CancellationReason(this.title, this.value);
}

extension CancelReasonOptions on OrderController {
  List<Map<String, dynamic>> get cancelReasonOptions => [
        {'title': 'Đặt nhầm món', 'value': 0},
        {'title': 'Thay đổi kế hoạch', 'value': 1},
        {'title': 'Không liên hệ được với quán', 'value': 2},
        {'title': 'Lý do khác', 'value': 3},
      ];
}

extension FeedbackReasonOptions on OrderController {
  List<Map<String, dynamic>> get feedbackReasonOptions => [
        {'title': 'Món ăn rất ngon', 'value': 0},
        {'title': 'Người giao hàng thân thiện', 'value': 1},
        {'title': 'Tất cả điều tốt', 'value': 2},
        {'title': 'Đánh giá khác', 'value': 3},
      ];
}

void showCancelDialog(OrderController controller, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Lý do bạn muốn huỷ đơn hàng?'),
        content: SizedBox(
          height: Get.height / 2,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Loop through options to create radio buttons
                for (var option in controller.cancelReasonOptions)
                  Obx(
                    () => RadioListTile<int>(
                      title: Text(option['title'] as String),
                      value: option['value'] as int,
                      groupValue: controller.selectedValue,
                      onChanged: controller.handleRadioValueChanged,
                    ),
                  ),
                Obx(
                  () => controller.selectedValue == 3
                      ? TextField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero),
                          onChanged: controller.handleOtherReasonChanged,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.selectedValue == null) {
                // Handle case where no option is selected
              } else if (controller.selectedValue == 3 &&
                  controller.otherReason.isEmpty) {
                // Handle case where "Other" is selected but reason is empty
                Get.snackbar('Hệ thống', 'Vui lòng nhập lý do huỷ',
                    duration: const Duration(seconds: 1));
              } else {
                // Handle successful selection with reason (if applicable)
                //lý do huỷ radio value (có cả other reason)
                print(controller.cancelReasonOptions[controller.selectedValue!]
                    ['title'] as String);
                Get.back(); // Close the dialog first
                Future.delayed(
                  Duration(seconds: 1),
                  () {
                    // Then show the snackbar after a delay
                    Get.snackbar('Hệ thống', 'Huỷ đơn hàng thành công');
                    if (controller.otherReason.isNotEmpty) {
                      //lý do khác value
                      print(controller.otherReason);
                    }
                  },
                );
              }
            },
            child: const Text('Xác nhận huỷ đơn'),
          ),
        ],
      );
    },
  );
}

void showFeedbackDialog(OrderController controller, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Đánh giá đơn hàng'),
        content: SizedBox(
          height: Get.height / 2,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Loop through options to create radio buttons
                for (var option in controller.feedbackReasonOptions)
                  Obx(
                    () => RadioListTile<int>(
                      title: Text(option['title'] as String),
                      value: option['value'] as int,
                      groupValue: controller.selectedValue,
                      onChanged: controller.handleRadioValueChanged,
                    ),
                  ),
                Obx(
                  () => controller.selectedValue == 3
                      ? TextField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero),
                          onChanged: controller.handleOtherReasonChanged,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.selectedValue == null) {
                // Handle case where no option is selected
              } else if (controller.selectedValue == 3 &&
                  controller.otherReason.isEmpty) {
                // Handle case where "Other" is selected but reason is empty
                Get.snackbar('Hệ thống', 'Vui lòng nhập đánh giá khác',
                    duration: const Duration(seconds: 1));
              } else {
                // Handle successful selection with reason (if applicable)
                //lý do huỷ radio value (có cả other reason)
                print(
                    controller.feedbackReasonOptions[controller.selectedValue!]
                        ['title'] as String);
                Get.back(); // Close the dialog first
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    // Then show the snackbar after a delay
                    Get.snackbar('Hệ thống', 'Đánh giá thành công');
                    if (controller.otherReason.isNotEmpty) {
                      //lý do khác value
                      print(controller.otherReason);
                    }
                  },
                );
              }
            },
            child: const Text('Gửi đánh giá'),
          ),
        ],
      );
    },
  );
}
