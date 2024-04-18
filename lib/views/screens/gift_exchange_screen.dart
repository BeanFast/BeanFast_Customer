import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/views/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../contrains/theme_color.dart';
import '/controllers/exchange_gift_controller.dart';
import '/utils/constants.dart';
import '/views/screens/gift_detail_screen.dart';
import 'loading_screen.dart';

class ExchangeGiftScreen extends StatelessWidget {
  const ExchangeGiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return LoadingScreen(
      future: () async {
        await authController.getCurrentUser();
      },
      child: Obx(
        () => currentProfile.value == null
            ? const ErrorScreen(message: 'Chưa có học sinh')
            : Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Đổi quà',
                  ),
                  actions: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() => Text(currentProfile.value!.wallets!.isEmpty
                              ? '0'
                              : currentProfile
                                  .value!.wallets!.first.balance!.obs.value
                                  .toInt()
                                  .toString())),
                          const SizedBox(width: 5),
                          const Icon(Iconsax.gift, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
                body: DefaultTabController(
                  length: 3,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: [
                          Tab(text: 'Quà'),
                          Tab(text: 'Tích điểm/ Dùng điểm'),
                          Tab(text: 'Lịch sử đổi thưởng'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            const ExchageGift(), // Đổi thưởng
                            const PointManagement(), // Thống kê
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: const Center(
                                  child: Text('Lịch sử đổi thưởng')),
                            ),
                          ],
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

class PointManagement extends StatelessWidget {
  const PointManagement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Month
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 50,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 198, 229, 245),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 198, 229, 245),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Text(
              'Tháng 3',
              style: Get.textTheme.titleMedium,
            ),
          ),
          //Data
          Column(
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Giao dịch',
                    index.toString(),
                    snackPosition: SnackPosition.TOP,
                  );
                },
                child: Card(
                  color: ThemeColor.itemColor,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey)),
                          child: const Icon(
                            Icons.point_of_sale,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Giao địch mã $index',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '03:11 - 03/03/2024',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodySmall,
                                  ),
                                  SizedBox(
                                    child: Text('+200.000 điểm',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExchageGift extends GetView<ExchangeGiftController> {
  const ExchageGift({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeGiftController());
    return LoadingScreen(
      future: controller.getData,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: controller.listData.map((gift) {
                return GestureDetector(
                  onTap: () {
                    Get.to(GiftDetailScreen(gift: gift));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Card(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      // color: Colors.red,
                                      gift.imagePath.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5, right: 10, bottom: 5),
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
                                              style: Get.textTheme.bodyLarge,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Text(
                                           'Còn lại: ${gift.inStock.toString()}' ,
                                            style: Get.textTheme.bodySmall,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                gift.points.toString(),
                                                style: Get.textTheme.bodyLarge!
                                                    .copyWith(
                                                  color: Colors.red,
                                                ),
                                                overflow: TextOverflow.ellipsis,
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
                                Container(
                                  width: 70,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(5)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      'Điểm không đủ để đổi quà !',
                                                      style: Get
                                                          .textTheme.bodyLarge,
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
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      'Đổi quà',
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Positioned(
                          //   top: 0,
                          //   right: 0,
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 6, vertical: 3),
                          //     decoration: const BoxDecoration(
                          //       color: Colors.red,
                          //       borderRadius: BorderRadius.only(
                          //         bottomLeft: Radius.circular(12),
                          //         topRight: Radius.circular(12),
                          //       ),
                          //     ),
                          //     child: const Text(
                          //       '40%',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 12,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
