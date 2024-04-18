import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/cart_controller.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../screens/product_detail_screen.dart';
import '/models/menu_detail.dart';
import '/utils/formater.dart';

class MenuItem extends GetView<CartController> {
  // final void Function() onTap;
  final String title;
  final String sessionId;
  final List<MenuDetail> list;
  final bool isCombo;

  const MenuItem({
    super.key,
    required this.sessionId,
    // required this.onTap,
    required this.list,
    required this.title,
    required this.isCombo,
  });
  @override
  Widget build(Object context) {
    return Visibility(
      visible: list.isNotEmpty,
      child: isCombo
          ? Row(
              children: list.map((e) {
                return GestureDetector(
                  onTap: () {
                    Get.to(ProductDetailScreen(food: e.food!));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                              fit: BoxFit.cover,
                              width: 150,
                              height: 100,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              e.food!.name.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                          // const Spacer(),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      Formater.formatMoney(e.price.toString()),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: const Color.fromRGBO(
                                            240, 103, 24, 1),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add_outlined)),
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
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Column(
                  children: list.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailScreen(food: e.food!));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ThemeColor.itemColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
                              ),
                              child: SizedBox(
                                height: 100,
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
                                          e.food!.imagePath.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 5, bottom: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                e.food!.name.toString(),
                                                style: Get.textTheme.bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              child: Text(
                                                'Loại: ${e.food!.category!.name}',
                                                style: Get.textTheme.bodySmall!
                                                    .copyWith(
                                                  color: Colors.black54,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                  visible:
                                                      e.food!.price != e.price,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        Formater.formatMoney(e
                                                            .food!.price
                                                            .toString()),
                                                        style: Get.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                      const SizedBox(width: 5),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    child: Text(
                                                      Formater.formatMoney(
                                                          e.price.toString()),
                                                      style: Get
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                        color: const Color
                                                            .fromRGBO(
                                                            240, 103, 24, 1),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Visibility(
                                              visible: controller.ifAbsent(
                                                  currentProfile.value!.id!,
                                                  sessionId,
                                                  e.id!),
                                              child: SizedBox(
                                                width: 40,
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.decreaseItemCart(
                                                        currentProfile
                                                            .value!.id!,
                                                        sessionId,
                                                        e.id!);
                                                  },
                                                  icon: const Icon(
                                                      Iconsax.minus_square),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: controller.ifAbsent(
                                                  currentProfile.value!.id!,
                                                  sessionId,
                                                  e.id!),
                                              child: Container(
                                                width: 30,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  controller.ifAbsent(
                                                          currentProfile
                                                              .value!.id!,
                                                          sessionId,
                                                          e.id!)
                                                      ? controller.listCart[
                                                              currentProfile
                                                                  .value!.id!]![
                                                              sessionId]![e.id!]
                                                          .toString()
                                                      : '0',
                                                  style:
                                                      Get.textTheme.bodyLarge,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.increaseItemCart(
                                                      currentProfile.value!.id!,
                                                      sessionId,
                                                      e.id!);
                                                },
                                                icon: const Icon(
                                                    Iconsax.add_square),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: e.food!.price != e.price,
                              child: Positioned(
                                top: 4,
                                right: 4,
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
                                    'SALE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
