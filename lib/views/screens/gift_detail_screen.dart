import 'package:beanfast_customer/contains/theme_color.dart';
import 'package:beanfast_customer/views/widgets/sbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/image_default.dart';
import '/models/gift.dart';
import '/views/screens/gift_exchange_checkout_detail_screen.dart';

class GiftDetailScreen extends StatelessWidget {
  final Gift gift;
  const GiftDetailScreen({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: CustomNetworkImage(gift.imagePath!,
                              fit: BoxFit.cover)),
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
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
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
                                          .copyWith(color: const Color.fromARGB(
                                                      255, 26, 128, 30)),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SButton(
              onPressed: () {
                Get.to(GiftCheckOutScreen(gift: gift));
              },
              text: 'Đổi quà',
              color: ThemeColor.textButtonColor,
              borderColor: ThemeColor.textButtonColor,
              textStyle: Get.textTheme.titleMedium!
                  .copyWith(color: ThemeColor.itemColor),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
