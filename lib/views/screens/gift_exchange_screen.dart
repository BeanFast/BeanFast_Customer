import 'package:beanfast_customer/views/widgets/point_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/exchange_gift_controller.dart';
import 'loading_screen.dart';

class GiftExchangeScreen extends StatelessWidget {
  const GiftExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi quà',
        ),
        actions: <Widget>[
          Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.card_giftcard, color: Colors.black),
                Text('Điểm: 100.000'),
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
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Giao địch mã $index',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('03:11 - 03/03/2024',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                    SizedBox(height: 5),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  width: 120,
                                  child: const Text('+200.000 điểm',
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
          child: Obx(() => Column(
                children: controller.listData.map((gift) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      // margin: const EdgeInsets.only(left: 10, right: 10),
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 100,
                                  child: Image.network(
                                    color: Colors.red,
                                    gift.imagePath.toString(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
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
                                                const TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        child: Text(
                                          '150.000',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.red),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: TextButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(5)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          // side: const BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Đổi quà',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }
}
