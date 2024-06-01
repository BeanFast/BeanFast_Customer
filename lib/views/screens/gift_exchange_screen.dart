import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '/controllers/auth_controller.dart';
import '/models/gift.dart';
import 'data_screen.dart';
import '/models/transaction.dart';
import 'exchange_gift_history_tabview.dart';
import 'gift_exchange_checkout_detail_screen.dart';
import 'gift_detail_screen.dart';
import 'loading_screen.dart';
import '/enums/status_enum.dart';
import '/contains/theme_color.dart';
import '/controllers/exchange_gift_controller.dart';
import '/utils/constants.dart';
import '/views/widgets/image_default.dart';
import '/utils/formater.dart';

class ExchangeGiftScreen extends GetView<ExchangeGiftController> {
  const ExchangeGiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeGiftController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi thưởng',
        ),
        centerTitle: false,
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
                    Formater.formatPoint(currentUser.value!.points.toString()),
                    style: Get.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Iconsax.gift, color: Colors.black, size: 20),
              ],
            ),
          ),
        ],
      ),
      body: LoadingScreen(
        future: Get.find<AuthController>().getUser,
        child: const DefaultTabController(
          length: 3,
          child: Column(
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
                    PointTransactionHistoryTabView(), // Lịch sử điểm
                    ExchangeGiftHistoryTabView(), // Lịch sử
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PointTransactionHistoryTabView extends GetView<ExchangeGiftController> {
  const PointTransactionHistoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.resetTransactionController();
    Get.put(ExchangeGiftController());
    return PagedListView<int, Transaction>(
      pagingController: controller.pagingTransactionController,
      builderDelegate: PagedChildBuilderDelegate<Transaction>(
        itemBuilder: (context, item, index) {
          IconData iconData =
              item.value! >= 0 ? Iconsax.wallet_add_1 : Iconsax.wallet_minus;
          var color = item.value! >= 0 ? Colors.green : Colors.red;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.exchangeGift!.code != null
                              ? "Đổi quà: #${item.exchangeGift!.code!}"
                              : item.game!.name != null
                                  ? "Chơi game: ${item.game!.name}"
                                  : "Hoàn thành đơn hàng: #${item.order!.code}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('HH:mm dd/MM/yy')
                                        .format(item.time!),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              width: 120,
                              child: Text(
                                item.value! > 0
                                    ? "+${Formater.formatPoint(item.value.toString())}"
                                    : Formater.formatPoint(
                                        item.value.toString()),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodyMedium!.copyWith(
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
        },
        noItemsFoundIndicatorBuilder: (context) => const DataScreen(
          hasData: false,
          message: 'Chưa có lịch sử',
          child: Center(),
        ),
        firstPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Lỗi tải trang'),
        ),
        newPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Lỗi tải trang mới'),
        ),
      ),
    );
  }
}

class ExchangeGiftTabView extends GetView<ExchangeGiftController> {
  const ExchangeGiftTabView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.resetGiftPagingController();
    return PagedListView<int, Gift>(
      pagingController: controller.pagingGiftController,
      builderDelegate: PagedChildBuilderDelegate<Gift>(
        itemBuilder: (context, item, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => GiftDetailScreen(gift: item));
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
                                item.imagePath.toString(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Text(
                                        item.name.toString(),
                                        style: Get.textTheme.bodyLarge,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      'Còn lại: ${item.inStock.toString()}',
                                      style: Get.textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          item.points.toString(),
                                          style:
                                              Get.textTheme.bodyLarge!.copyWith(
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
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(5)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (currentUser.value!.points! >=
                                    item.points!) {
                                  Get.to(() => GiftCheckOutScreen(gift: item));
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
        },
        noItemsFoundIndicatorBuilder: (context) => const DataScreen(
          hasData: false,
          message: 'Chưa có lịch sử',
          child: Center(),
        ),
        firstPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Lỗi tải trang'),
        ),
        newPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Lỗi tải trang mới'),
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
