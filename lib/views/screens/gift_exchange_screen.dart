import 'package:beanfast_customer/models/profile.dart';
import 'package:beanfast_customer/services/profile_service.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:beanfast_customer/views/screens/gift_detail_screen.dart';
import 'package:beanfast_customer/views/widgets/point_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/exchange_gift_controller.dart';
import 'loading_screen.dart';

class ExchangeGiftScreen extends StatelessWidget {
  ExchangeGiftScreen({super.key});
  var profile = null;
  RxDouble balance = 0.0.obs;
  @override
  Widget build(BuildContext context) {
    print(currentProfile.value.wallets.toString());
    var profile = currentProfile.value;
    print(currentProfile.value.wallets.toString());

    return LoadingScreen(
      future: () async {
        profile = await ProfileService().getById(currentProfile.value.id!);
        print(profile.id.toString());
        balance = profile.wallets!.isEmpty
            ? 0.0.obs
            : profile.wallets!.first.balance!.obs;
        print(balance);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Đổi quà',
          ),
          actions: <Widget>[
            Container(
              width: 170,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.card_giftcard, color: Colors.black),
                  Text('Điểm: ${balance.value.toString()}'),
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
                    Container(
                      child: const Center(child: Text('Lịch sử đổi thưởng')),
                    ),
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

class PointManagement extends StatelessWidget {
  const PointManagement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PointDashboard(),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Giao dịch',
                    index.toString(),
                    snackPosition: SnackPosition.TOP,
                  );
                },
                child: Container(
                  color: index % 2 == 0 ? Colors.white : Colors.grey[200],
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: Text('03:11 - 03/03/2024',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  width: 120,
                                  child: const Text('+200.000 điểm',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
          ),
        ),
      ],
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
                                              const Icon(Icons.card_giftcard,
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
                                    onPressed: () {},
                                    child: Text(
                                      'Đổi quà',
                                      style: Get.textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Text(
                                '40%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
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
