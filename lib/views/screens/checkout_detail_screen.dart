import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/views/widgets/row_info_confirm_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../enums/menu_index_enum.dart';
import '../widgets/result_screen_widget.dart';
import '/controllers/cart_controller.dart';
import '/utils/constants.dart';
import '/utils/formater.dart';
import '/views/screens/deposit_screen.dart';
import '/views/screens/loading_screen.dart';
import 'splash_screen.dart';

class CheckOutDetailScreen extends GetView<CartController> {
  const CheckOutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: LoadingScreen(
        future: controller.getLocationsData,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      children: controller.listCart.entries
                          .map(
                            (profile) => Column(
                              children: profile.value.entries
                                  .map(
                                    (session) => Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 50,
                                                  width: Get.width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      topRight:
                                                          Radius.circular(12),
                                                    ),
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    controller
                                                        .listProfile[
                                                            profile.key]!
                                                        .fullName
                                                        .toString(),
                                                    style: Get
                                                        .textTheme.titleMedium,
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        leading: const Icon(
                                                            Iconsax.location),
                                                        title: const Text(
                                                            'Địa chỉ nhận hàng'),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(controller
                                                                .listProfile[
                                                                    profile
                                                                        .key]!
                                                                .school!
                                                                .name
                                                                .toString()),
                                                            Text(controller
                                                                .listSession[
                                                                    session
                                                                        .key]!
                                                                .sessionDetails!
                                                                .where((e) =>
                                                                    e.id! ==
                                                                    controller
                                                                            .listSessionDetailId[
                                                                        session
                                                                            .key])
                                                                .first
                                                                .location!
                                                                .name
                                                                .toString()),
                                                          ],
                                                        ),
                                                        trailing: IconButton(
                                                          iconSize: 24,
                                                          onPressed: () {
                                                            gateSelection(
                                                                context,
                                                                session.key);
                                                          },
                                                          icon: const Icon(Iconsax
                                                              .arrow_circle_right),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Iconsax.truck_time),
                                                        title: Text(
                                                            'Thời gian nhận hàng',
                                                            style: Get.textTheme
                                                                .bodyMedium),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Từ ${DateFormat('HH:mm').format(controller.listSession[session.key]!.deliveryStartTime!)} đến ${DateFormat('HH:mm, dd/MM/yy').format(controller.listSession[session.key]!.deliveryEndTime!)}',
                                                                style: Get
                                                                    .textTheme
                                                                    .bodyMedium),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children:
                                                            session
                                                                .value.entries
                                                                .map(
                                                                  (menuDetail) =>
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            10,
                                                                        top:
                                                                            10),
                                                                    height: 90,
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              80,
                                                                          height:
                                                                              80,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(12)),
                                                                            child:
                                                                                Image.network(
                                                                              controller.listMenuDetail[menuDetail.key]!.food!.imagePath!,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 15,
                                                                                right: 15,
                                                                                top: 5,
                                                                                bottom: 5),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: SizedBox(
                                                                                    child: Text(
                                                                                      controller.listMenuDetail[menuDetail.key]!.food!.name.toString(),
                                                                                      style: Get.textTheme.bodyMedium,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 2,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 2),
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    'Phân loại: ${controller.listMenuDetail[menuDetail.key]!.food!.category!.name.toString()}',
                                                                                    style: Get.textTheme.bodySmall!.copyWith(color: Colors.black54),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 2),
                                                                                Row(
                                                                                  children: [
                                                                                    if (controller.listMenuDetail[menuDetail.key]!.price != controller.listMenuDetail[menuDetail.key]!.food!.price)
                                                                                      Text(
                                                                                        Formater.formatMoney(controller.listMenuDetail[menuDetail.key]!.food!.price.toString()),
                                                                                        style: Get.textTheme.bodySmall!.copyWith(decoration: TextDecoration.lineThrough),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    if (controller.listMenuDetail[menuDetail.key]!.price != controller.listMenuDetail[menuDetail.key]!.food!.price) const SizedBox(width: 10),
                                                                                    Text(
                                                                                      Formater.formatMoney(controller.listMenuDetail[menuDetail.key]!.price.toString()),
                                                                                      style: Get.textTheme.bodySmall!.copyWith(color: Color.fromRGBO(240, 103, 24, 1)),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                    const Spacer(),
                                                                                    Text(
                                                                                      'x ${menuDetail.value}',
                                                                                      style: Get.textTheme.bodySmall,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                const SizedBox(height: 2),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                          .toList(),
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
                                    color: Colors.amber,
                                  ),
                                ),
                                Text('Chi tiết thanh toán',
                                    style: Get.textTheme.titleMedium),
                              ],
                            ),
                            RowInforWidget(
                              title: 'Tổng đơn hàng ',
                              data: Formater.formatMoney(
                                controller.totalPrice.toString(),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RowInforWidget(
                              title: 'Giảm giá sản phẩm ',
                              data: Formater.formatMoney(
                                (controller.totalPrice - controller.total.value)
                                    .toString(),
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
                                        controller.total.value.toString()),
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
                    color: Colors.grey
                        .withOpacity(0.5), // Màu của đổ bóng và độ mờ
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
                                controller.total.value.toString()),
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
                            ThemeColor.textButtonColor), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ThemeColor.textButtonColor), // Background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: ThemeColor.textButtonColor),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (currentUser.value!.balance! <
                            controller.total.value) {
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
                                              Get.to(DepositeScreen());
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
                        } else {
                          bool result = await controller.checkout();
                          Get.to(
                            ResultScreenWidget(
                              isSuccess: result,
                              content:
                                  'Cảm ơn bạn đã ủng hộ BeanFast!.',
                              ontapNameLeftSide: 'Trang chủ',
                              ontapLeftSide: () {
                                changePage(MenuIndexState.home.index);
                                Get.offAll(const SplashScreen());
                              },
                              ontapNameRightSide: 'Đơn hàng',
                              ontapRightSide: () {
                                changePage(MenuIndexState.order.index);
                                Get.offAll(const SplashScreen());
                              },
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Đặt hàng',
                        style: Get.textTheme.titleLarge!
                            .copyWith(color: ThemeColor.itemColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> gateSelection(BuildContext context, String sessionId) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
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
                children: controller.listSession[sessionId]!.sessionDetails!
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
                            child: Image.network(
                              controller
                                  .listLocation[sessionDetail.location!.id]!
                                  .imagePath
                                  .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(controller
                              .listLocation[sessionDetail.location!.id]!.name
                              .toString()),
                          subtitle: Text(controller
                              .listLocation[sessionDetail.location!.id]!
                              .description
                              .toString()),
                          onTap: () {
                            controller.updateSessionDetai(
                                sessionId, sessionDetail.id!);
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
