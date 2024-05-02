import 'package:beanfast_customer/views/widgets/image_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../enums/menu_index_enum.dart';
import '/enums/status_enum.dart';
import '/controllers/auth_controller.dart';
import '/controllers/transaction_controller.dart';
import '/contains/theme_color.dart';
import '/controllers/exchange_gift_controller.dart';
import '/utils/constants.dart';
import 'exchange_gift_history_tabview.dart';
import 'gift_exchange_checkout_detail_screen.dart';
import 'error_screen.dart';
import 'gift_detail_screen.dart';
import 'loading_screen.dart';
import '/utils/formater.dart';
import 'splash_screen.dart';

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
                  leading: IconButton(
                    icon:  const Icon(Iconsax.arrow_left_2),
                    onPressed: () {
                      changePage(MenuIndexState.home.index);
                      Get.off(const SplashScreen());
                    },
                  ),
                  title: const Text(
                    'Đổi quà',
                  ),
                  actions: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => Text(
                              Formater.formatPoint(currentProfile
                                  .value!.wallet!.balance
                                  .toString()),
                              style: Get.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Iconsax.gift,
                              color: Colors.black, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                body: const DefaultTabController(
                  length: 3,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
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
                            ExchangeGiftTabView(), // Đổi thưởng
                            PointManagementTabView(), // Lịch sử điểm
                            ExchangeGiftHistoryTabView(), // Lịch sử
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

class PointManagementTabView extends GetView<TransactionController> {
  const PointManagementTabView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionController());
    return LoadingScreen(
      future: () async {
        await controller.getPointTransaction(currentProfile.value!.id!);
      },
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: controller.mapTransactions.entries
                .map(
                  (transaction) => Column(
                    children: [
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
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          'Tháng ${transaction.key}',
                          style: Get.textTheme.titleMedium,
                        ),
                      ),
                      Column(
                        children: transaction.value.map((element) {
                          IconData iconData = element.value! > 0
                              ? Iconsax.wallet_add_1
                              : Iconsax.wallet_minus;
                          var color =
                              element.value! > 0 ? Colors.green : Colors.red;
                          return Card(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      iconData,
                                      color: ThemeColor.iconColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          element.order!.code != null
                                              ? "Đơn hàng: #${element.order!.code!}"
                                              : element.exchangeGift!.code !=
                                                      null
                                                  ? "Đổi quà: #${element.exchangeGift!.code}"
                                                  : "Chơi game : ${element.game!.name}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              Get.textTheme.bodyLarge!.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateFormat('HH:mm dd/MM/yy')
                                                        .format(element.time!),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        Get.textTheme.bodySmall,
                                                  ),
                                                  const SizedBox(height: 5),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              width: 120,
                                              child: Text(
                                                element.value! > 0
                                                    ? "+${Formater.formatPoint(element.value.toString())}"
                                                    : Formater.formatPoint(
                                                        element.value
                                                            .toString()),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: color,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ExchangeGiftTabView extends GetView<ExchangeGiftController> {
  const ExchangeGiftTabView({super.key});

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
                    margin: const EdgeInsets.only(bottom: 1),
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
                                    child: CustomNetworkImage(
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
                                            'Còn lại: ${gift.inStock.toString()}',
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
                                                  color: const Color.fromARGB(
                                                      255, 26, 128, 30),
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
                                    onPressed: () {
                                      if (currentProfile
                                              .value!.wallet!.balance! >
                                          gift.points!) {
                                        Get.to(GiftCheckOutScreen(gift: gift));
                                      } else {
                                        Get.snackbar(
                                          'Đổi quà thất bại',
                                          'Bạn không đủ điểm',
                                          snackPosition: SnackPosition.TOP,
                                          duration: 1.seconds,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Đổi quà',
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: ThemeColor.textButtonColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

class ExchangeGiftHistoryTabView extends GetView<ExchangeGiftController> {
  const ExchangeGiftHistoryTabView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeGiftController());

    return const Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: 'Đang chuẩn bị'),
                Tab(text: 'Đang giao'),
                Tab(text: 'Hoàn thành'),
                Tab(text: 'Đã hủy'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ExchangeGiftHistoryTabBarView(
                    exchangeGiftStatus: ExchangeGiftStatus.preparing,
                  ), // Đang chuẩn bị
                  ExchangeGiftHistoryTabBarView(
                    exchangeGiftStatus: ExchangeGiftStatus.delivering,
                  ), // Đang giao
                  ExchangeGiftHistoryTabBarView(
                    exchangeGiftStatus: ExchangeGiftStatus.completed,
                  ), // Hoàn thành
                  ExchangeGiftHistoryTabBarView(
                    exchangeGiftStatus: ExchangeGiftStatus.cancelled,
                  ), // Đã hủy
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
