import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timelines/timelines.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đã giao hàng'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Column(
              children: [
                //
                GestureDetector(
                  onTap: () {
                    Get.to(const OrderTimeline());
                  },
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
                        child:
                            Text('Cổng số 1', style: Get.textTheme.bodySmall),
                      ),
                      const SizedBox(height: 5),
                      if (true)
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
                            Text('T4, 3 Tháng 4 2024',
                                style: Get.textTheme.bodySmall),
                          ],
                        ),
                    ],
                  ),
                ),
                const Divider(),
                // Order ID
                Row(
                  children: [
                    Text('Mã đơn hàng', style: Get.textTheme.labelLarge),
                    const Spacer(),
                    Text('#112313123', style: Get.textTheme.bodySmall),
                    TextButton(
                        onPressed: () {
                          Clipboard.setData(
                              const ClipboardData(text: '112313123'));
                          Get.snackbar(
                            'Đã sao chép mã đơn hàng',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            duration: const Duration(seconds: 1),
                            colorText: Colors.black,
                          );
                        },
                        child: Text('SAO CHÉP',
                            style: Get.textTheme.bodySmall!
                                .copyWith(color: Colors.green)))
                  ],
                ),
                const Divider(),
                // Timeline
                FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0.3,
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.after,
                    contentsAlign: ContentsAlign.basic,
                    oppositeContentsBuilder: (context, index) => Container(
                      padding: const EdgeInsets.only(right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('3 Tháng 4', style: Get.textTheme.labelLarge),
                          Text('13:06', style: Get.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    contentsBuilder: (context, index) => Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Đã giao', style: Get.textTheme.labelLarge),
                          Text('Giao hàng thành công',
                              style: Get.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    indicatorBuilder: (context, index) {
                      if (index == 0) {
                        return const OutlinedDotIndicator(
                          color: Colors.green,
                          size: 25,
                          child: Icon(
                            Iconsax.box_tick,
                            size: 15,
                          ),
                        );
                      } else if (index == 1) {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                          child: Icon(
                            Iconsax.car,
                            size: 15,
                          ),
                        );
                      } else if (index == 3) {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                          child: Icon(
                            Iconsax.box,
                            size: 15,
                          ),
                        );
                      } else if (index == 4) {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                          child: Icon(
                            Iconsax.note_text4,
                            size: 15,
                          ),
                        );
                      } else {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                        );
                      }
                    },
                    connectorBuilder: (context, index, connectorType) {
                      return const DecoratedLineConnector(
                        thickness: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      );
                    },
                    itemCount: 5,
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
