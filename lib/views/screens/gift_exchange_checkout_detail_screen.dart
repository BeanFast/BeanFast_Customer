import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '/controllers/exchange_gift_controller.dart';
import '/models/gift.dart';
import '/contrains/theme_color.dart';
import '/utils/constants.dart';
import '/utils/formater.dart';

class GiftCheckOutScreen extends GetView<ExchangeGiftController> {
  const GiftCheckOutScreen({
    super.key,
    required this.gift,
  });

  final Gift gift;
  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeGiftController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showSessionPicker();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi quà'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                alignment: Alignment.centerLeft,
                                height: 50,
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  currentProfile.value!.fullName.toString(),
                                  style: Get.textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: ThemeColor.itemColor,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Iconsax.location),
                                title: const Text('Địa chỉ nhận hàng'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentProfile.value!.school!.name
                                        .toString()),
                                    Obx(
                                      () => Text(controller
                                                  .selectedSession.value ==
                                              null
                                          ? 'Chưa chọn địa điểm nhận hàng'
                                          : controller.selectedSession.value!
                                              .sessionDetails!
                                              .firstWhere((e) =>
                                                  e.id! ==
                                                  controller.sessionDetailId)
                                              .location!
                                              .name
                                              .toString()),
                                    )
                                  ],
                                ),
                                trailing: IconButton(
                                  iconSize: 24,
                                  onPressed: () {
                                    gateSelection();
                                  },
                                  icon: const Icon(Iconsax.arrow_circle_right),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => showSessionPicker(),
                                child: ListTile(
                                    leading: const Icon(Iconsax.truck_time),
                                    title: Text('Thời gian nhận hàng',
                                        style: Get.textTheme.bodyMedium),
                                    subtitle: Obx(
                                      () => Text(
                                          controller.selectedSession.value ==
                                                  null
                                              ? 'Chưa chọn khung giờ nhận hàng'
                                              : 'Từ ${DateFormat('HH:mm').format(controller.selectedSession.value!.deliveryStartTime!)} đến ${DateFormat('HH:mm, dd/MM/yy').format(controller.selectedSession.value!.deliveryEndTime!)}',
                                          style: Get.textTheme.bodyMedium),
                                    ),
                                    trailing: IconButton(
                                      iconSize: 24,
                                      onPressed: () {
                                        showSessionPicker();
                                      },
                                      icon: const Icon(Iconsax.edit),
                                    )),
                              ),
                              //Gift Item
                              Container(
                                height: 100,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          gift.imagePath.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                            right: 10,
                                            bottom: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  gift.name.toString(),
                                                  style:
                                                      Get.textTheme.bodyLarge,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                child: Text(
                                                  'x1',
                                                  style:
                                                      Get.textTheme.bodySmall,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    Formater.formatPoint(
                                                        gift.points.toString()),
                                                    style: Get
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      color: Colors.red,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(Iconsax.gift,
                                                      color: Colors.orange)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 30,
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  Icons.content_paste_go_outlined,
                                  // color: Colors.amber,
                                ),
                              ),
                              Text('Chi tiết thanh toán',
                                  style: Get.textTheme.titleMedium),
                            ],
                          ),
                          // RowInforWidget(
                          //   title: 'Tổng đơn hàng ',
                          //   data: Formater.formatPoint(
                          //     gift.points.toString(),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  'Tổng thanh toán',
                                  style: Get.textTheme.bodyLarge,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  Formater.formatPoint(
                                    gift.points.toString(),
                                  ),
                                  textAlign: TextAlign.right,
                                  style: Get.textTheme.bodyLarge!,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Màu của đổ bóng và độ mờ
                  spreadRadius: 5, // Độ lan rộng của đổ bóng
                  blurRadius: 7, // Độ mờ của đổ bóng
                  offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                ),
              ],
            ),
            height: 60,
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20 - 15 - 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Tổng thanh toán',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                          Formater.formatPoint(
                            gift.points.toString(),
                          ),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(240, 103, 24, 1),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 140,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      bool result =
                          await controller.createExchangeGift(gift.id!);
                      Get.snackbar(
                        'Đổi quà ${result ? 'thành công' : 'thất bại'}',
                        controller.messages.toString(),
                        snackPosition: SnackPosition.TOP,
                      );
                    },
                    child: Text(
                      'Đặt hàng',
                      style: Get.textTheme.titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSessionPicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate == null) {
      Get.back();
      return;
    } else {
      await controller.getSession(
          currentProfile.value!.school!.id!, pickedDate);
    }

    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return SizedBox(
          width: Get.width,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Chọn thời gian nhận hàng',
                    style: Get.textTheme.titleLarge,
                  ),
                ),
                if (controller.listSession.isEmpty)
                  const Center(
                    child: Text('Không tồn tại khung giờ nào'),
                  ),
                Column(
                  children: controller.listSession
                      .map(
                        (session) => ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(
                              'Từ ${DateFormat('HH:mm').format(session.deliveryStartTime!)} đến ${DateFormat('HH:mm dd-MM-yy').format(session.deliveryEndTime!)}'),
                          onTap: () {
                            controller.selectSession(session);

                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) async {
      if (controller.selectedSession.value == null) {
        showSessionPicker();
      }
    });
  }

  Future<dynamic> gateSelection() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            right: 10,
            left: 10,
          ),
          child: Column(
            children: [
              const Icon(Icons.more_horiz_outlined),
              Column(
                children: controller.selectedSession.value!.sessionDetails!
                    .map(
                      (sessionDetail) => Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey),
                            ),
                            // child: Image.network(
                            //   sessionDetail.location!.imagePath.toString(),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          title: Text(sessionDetail.location!.name.toString()),
                          // subtitle: Text(
                          //     sessionDetail.location!.description.toString()),
                          onTap: () {
                            controller.sessionDetailId = sessionDetail.id!;
                            Get.back();
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
