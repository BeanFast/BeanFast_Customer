import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/contains/theme_color.dart';
import '/controllers/cart_controller.dart';
import '/utils/constants.dart';
import '/views/widgets/image_default.dart';
import '/views/screens/product_detail_screen.dart';
import '/models/menu_detail.dart';
import '/utils/formater.dart';

class MenuItem extends GetView<CartController> {
  final String title;
  final String sessionId;
  final List<MenuDetail> list;
  final bool isCombo;

  const MenuItem({
    super.key,
    required this.sessionId,
    required this.list,
    required this.title,
    required this.isCombo,
  });
  @override
  Widget build(Object context) {
    return Visibility(
      visible: list.isNotEmpty,
      child: isCombo
          ?
//combo
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                Row(
                  children: list.map((menuDetail) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            menuDetail.food!.price != menuDetail.price
                                ? Get.to(
                                    () => ProductDetailScreen(
                                      food: menuDetail.food!,
                                      salePrice: menuDetail.price,
                                    ),
                                  )
                                : Get.to(
                                    () => ProductDetailScreen(
                                        food: menuDetail.food!),
                                  );
                          },
                          child: Card(
                            child: SizedBox(
                              width: 170,
                              height: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: CustomNetworkImage(
                                      menuDetail.food!.imagePath.toString(),
                                      fit: BoxFit.cover,
                                      width: 170,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      menuDetail.food!.name.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.bodySmall,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: menuDetail.food!.price !=
                                              menuDetail.price,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                Formater.formatMoney(menuDetail
                                                    .food!.price
                                                    .toString()),
                                                style: Get.textTheme.bodyLarge!
                                                    .copyWith(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                                overflow: TextOverflow.ellipsis,
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
                                                  menuDetail.price.toString()),
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(
                                                color: const Color.fromRGBO(
                                                    240, 103, 24, 1),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => MenuCartBox(
                                      count: controller
                                              .dataList[
                                                  currentProfile.value!.id!]
                                                  ?[sessionId]?[menuDetail.id!]?.value
                                               ??
                                          0,
                                      decrease: () =>
                                          controller.decreaseItemCart(
                                              currentProfile.value!.id!,
                                              sessionId,
                                              menuDetail.id!),
                                      increase: () =>
                                          controller.increaseItemCart(
                                              currentProfile.value!.id!,
                                              sessionId,
                                              menuDetail.id!),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: menuDetail.food!.price != menuDetail.price,
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
                    );
                  }).toList(),
                ),
              ],
            )
          :
//food
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Column(
                  children: list.map((menuDetail) {
                    return GestureDetector(
                      onTap: () {
                        menuDetail.food!.price != menuDetail.price
                            ? Get.to(() => ProductDetailScreen(
                                  food: menuDetail.food!,
                                  salePrice: menuDetail.price,
                                ))
                            : Get.to(() =>
                                ProductDetailScreen(food: menuDetail.food!));
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
                                        child: CustomNetworkImage(
                                          menuDetail.food!.imagePath.toString(),
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
                                                menuDetail.food!.name
                                                    .toString(),
                                                style: Get.textTheme.bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              child: Text(
                                                'Loại: ${menuDetail.food!.category!.name}',
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
                                                      menuDetail.food!.price !=
                                                          menuDetail.price,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        Formater.formatMoney(
                                                            menuDetail
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
                                                          menuDetail.price
                                                              .toString()),
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
                                        () => MenuCartBox(
                                          count: controller
                                              .dataList[
                                                  currentProfile.value!.id!]
                                                  ?[sessionId]?[menuDetail.id!]?.value

                                               ??
                                          0,
                                          decrease: () =>
                                              controller.decreaseItemCart(
                                                  currentProfile.value!.id!,
                                                  sessionId,
                                                  menuDetail.id!),
                                          increase: () =>
                                              controller.increaseItemCart(
                                                  currentProfile.value!.id!,
                                                  sessionId,
                                                  menuDetail.id!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  menuDetail.food!.price != menuDetail.price,
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

class MenuCartBox extends StatelessWidget {
  const MenuCartBox(
      {super.key,
      required this.count,
      required this.decrease,
      required this.increase});
  final int count;
  final Function() decrease;
  final Function() increase;

  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: count != 0,
              child: SizedBox(
                width: 40,
                child: IconButton(
                  onPressed: decrease,
                  icon: const Icon(Iconsax.minus_square),
                ),
              ),
            ),
            Visibility(
              visible: count != 0,
              child: Container(
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: Get.textTheme.bodyLarge,
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: IconButton(
                onPressed: increase,
                icon: const Icon(Iconsax.add_square),
              ),
            ),
          ],
        );
  }
}
