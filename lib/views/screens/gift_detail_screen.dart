import 'package:beanfast_customer/models/gift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GiftDetailScreen extends StatelessWidget {
  final Gift gift;
  const GiftDetailScreen({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.8,
                      child: Image.network(gift.imagePath!, fit: BoxFit.cover),
                    ),
                    Stack(
                      children: [
                        Card(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gift.name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      gift.points!.toString(),
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: Colors.red),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.card_giftcard,
                                        color: Colors.orange)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
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
                          ),
                        ),
                      ],
                    ),
                    // Card(
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     padding: const EdgeInsets.all(10),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text('Mô tả', style: TextStyle(fontSize: 16)),
                    //         Text(gift.description!),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: Get.height / 20),
              width: Get.width / 1.2,
              height: Get.height / 15,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green), // Background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
                                Text(
                                  'Điểm không đủ để đổi quà !',
                                  style: Get.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
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
                    Get.back();
                  }
                },
                child: Text('Đổi quà',
                    style: Get.textTheme.titleMedium!
                        .copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
