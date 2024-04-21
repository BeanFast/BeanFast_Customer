import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '/models/session.dart';
import '/services/session_service.dart';
import '/contrains/theme_color.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';
import '/utils/formater.dart';
import '/views/widgets/row_info_confirm_item_widget.dart';

class GiftCheckOutScreen extends StatelessWidget {
  const GiftCheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfirmExchangeGiftController controller =
        Get.put(ConfirmExchangeGiftController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showSessionPicker(context, controller);
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
                                  'Tên người nhận',
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
                                subtitle: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Địa chỉ nhận hàng'),
                                    Text('Địa chỉ nhận hàng'),
                                  ],
                                ),
                                trailing: IconButton(
                                  iconSize: 24,
                                  onPressed: () {
                                    // gateSelection(context, session.key);
                                  },
                                  icon: const Icon(Iconsax.arrow_circle_right),
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    showSessionPicker(context, controller),
                                child: ListTile(
                                    leading: const Icon(Iconsax.truck_time),
                                    title: Obx(
                                      () => Text(
                                        controller.selectedSession.value == null
                                            ? ''
                                            : DateFormat('HH:mm dd-MM-yy')
                                                .format(controller
                                                    .selectedSession
                                                    .value!
                                                    .deliveryStartTime!),
                                        style: Get.textTheme.bodyMedium,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      iconSize: 24,
                                      onPressed: () {
                                        showSessionPicker(context, controller);
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
                                          'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
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
                                                  'Tên quà',
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
                                                    '10',
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
                          RowInforWidget(
                            title: 'Tổng đơn hàng ',
                            data: Formater.formatMoney(
                              '100000',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          RowInforWidget(
                            title: 'Giảm giá sản phẩm ',
                            data: Formater.formatMoney(
                              ('100000').toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
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
                                  Formater.formatMoney(
                                    ('1200000').toString(),
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
                          Formater.formatMoney(
                            ('100000').toString(),
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
                      if (false) {
                        showDialog(
                          context: context,
                          // barrierDismissible: true,
                          builder: (BuildContext context) {
                            // Return object of type Dialog
                            return AlertDialog(
                              content: SizedBox(
                                height: 160,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: Get.width,
                                      height: 100,
                                      child: Lottie.asset(
                                        "assets/unsuccess.json",
                                        repeat: true,
                                        fit: BoxFit.contain,
                                        // animate: true,
                                      ),
                                    ),
                                    const Text('Thông báo',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Số dư không đủ, ',
                                          style: Get.textTheme.bodyLarge,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Get.to(DepositeScreen());
                                          },
                                          child: Text(
                                            'nạp thêm',
                                            style: Get.textTheme.bodyLarge!
                                                .copyWith(
                                                    color: Color.fromRGBO(
                                                        240, 103, 24, 1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        //Không đủ số dư - nạp tiền
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            // Return object of type Dialog
                            return AlertDialog(
                              content: SizedBox(
                                height: 180,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Lottie.asset(
                                        "assets/success.json",
                                        repeat: false,
                                        animate: true,
                                      ),
                                    ),
                                    const Text(
                                      'Đặt hàng thành công !',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pop(context);
                        //Api đổi quà
                      }
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
}

class ConfirmExchangeGiftController extends GetxController {
  Rx<Session?> selectedSession = Rx<Session?>(null);
  RxList<Session> listSession = <Session>[].obs;

  void clear() {
    listSession.clear();
    selectedSession.value = null;
  }

  Future getSession(String schoolId, DateTime dateTime) async {
    clear();
    try {
      listSession.value = await SessionService()
          .getSessionsBySchoolId(schoolId, dateTime, false);
      logger.e(listSession.length);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  // void selectSession(Session session) {
  //   selectedSession.value = session;
  // }
}

void showSessionPicker(
    BuildContext context, ConfirmExchangeGiftController controller) async {
  while (controller.selectedSession.value == null) {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate == null) {
      if (controller.selectedSession.value == null) {
        Get.back();
      }
      return;
    } else {
      controller.getSession(currentProfile.value!.school!.id!, pickedDate);
    }

    // bool sessionSelected = false;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Chọn thời gian nhận hàng',
                  style: Get.textTheme.titleLarge,
                ),
              ),
              Obx(
                () => Column(
                  children: controller.listSession
                      .map(
                        (session) => ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(
                              'Từ ${DateFormat('HH:mm').format(session.deliveryStartTime!)} đến ${DateFormat('HH:mm dd-MM-yy').format(session.deliveryEndTime!)}'),
                          onTap: () {
                            controller.selectedSession.value = session;
                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // .then((value) {
  //   if (controller.selectedSession.value == null) {
  //     Get.back();
  //   }
  // });
}


//  Future<dynamic> gateSelection(BuildContext context, String sessionId) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.5,
//           padding: const EdgeInsets.only(
//             top: 20,
//             bottom: 20,
//             right: 10,
//             left: 10,
//           ),
//           child: Column(
//             children: [
//               const Icon(Icons.more_horiz_outlined),
//               Column(
//                 children: controller.listSession[sessionId]!.sessionDetails!
//                     .map(
//                       (sessionDetail) => Container(
//                         decoration: const BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(
//                               color: Colors.grey,
//                               width: 0.5,
//                             ),
//                           ),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(color: Colors.grey),
//                             ),
//                             child: Image.network(
//                               controller
//                                   .listLocation[sessionDetail.location!.id]!
//                                   .imagePath
//                                   .toString(),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           title: Text(controller
//                               .listLocation[sessionDetail.location!.id]!.name
//                               .toString()),
//                           subtitle: Text(controller
//                               .listLocation[sessionDetail.location!.id]!
//                               .description
//                               .toString()),
//                           onTap: () {
//                             controller.updateSessionDetai(
//                                 sessionId, sessionDetail.id!);
//                             Get.back();
//                           },
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
