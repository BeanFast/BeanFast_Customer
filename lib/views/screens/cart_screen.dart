import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/views/widgets/image_default.dart';
import '/controllers/home_controller.dart';
import '/views/screens/checkout_detail_screen.dart';
import '/contains/theme_color.dart';
import '/controllers/cart_controller.dart';
import '/utils/formater.dart';
import '/views/screens/loading_screen.dart';
import 'data_screen.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: LoadingScreen(
        future: controller.fetchData,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Màu của đổ bóng và độ mờ
                    spreadRadius: 5, // Độ lan rộng của đổ bóng
                    blurRadius: 7, // Độ mờ của đổ bóng
                    offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              height: 40,
              child: Obx(
                () => Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        homeController.isMoneyVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 16,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        homeController.toggleMoneyVisibility();
                      },
                    ),
                    Text(
                      homeController.moneyValue.value,
                      style: Get.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => Expanded(
                child: DataScreen(
                  hasData: controller.dataList.isNotEmpty,
                  message: 'Giỏ hàng trống',
                  child: Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: controller.dataList.entries.map((profile) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(12)),
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.centerLeft,
                                          height: 50,
                                          width: Get.width,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            controller.listProfile[profile.key]!
                                                .fullName
                                                .toString(),
                                            style: Get.textTheme.titleMedium,
                                          ),
                                        ),
                                        Container(
                                          color: ThemeColor.itemColor,
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Column(
                                            children: profile.value.entries
                                                .map(
                                                  (session) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 5),
                                                        child: Row(
                                                          children: [
                                                            Text('Mở đặt đến',
                                                                style: Get
                                                                    .textTheme
                                                                    .bodyMedium),
                                                            Text(
                                                              ' ${DateFormat('HH:mm, dd/MM/yyyy').format(controller.listSession[session.key]!.orderEndTime!)}',
                                                              style: Get.textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children:
                                                            session.value.entries
                                                                .map(
                                                                  (menuDetail) =>
                                                                      Dismissible(
                                                                    key: Key(
                                                                        menuDetail
                                                                            .key),
                                                                    direction:
                                                                        DismissDirection
                                                                            .endToStart,
                                                                    confirmDismiss:
                                                                        (direction) async {
                                                                      return await showDeleteDialog(
                                                                        () async {
                                                                          await controller.deleteItemFromCart(
                                                                              profile.key,
                                                                              session.key,
                                                                              menuDetail.key);
                                                                          Get.back();
                                                                        },
                                                                      );
                                                                      // showDialog(
                                                                      //   context:
                                                                      //       context,
                                                                      //   builder:
                                                                      //       (BuildContext context) {
                                                                      //     return AlertDialog(
                                                                      //       title: const Text("Xác nhận"),
                                                                      //       content: const Text("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?"),
                                                                      //       actions: <Widget>[
                                                                      //         TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Xoá")),
                                                                      //         TextButton(
                                                                      //           onPressed: () => Navigator.of(context).pop(false),
                                                                      //           child: const Text("Huỷ"),
                                                                      //         ),
                                                                      //       ],
                                                                      //     );
                                                                      //   },
                                                                      // );
                                                                    },
                                                                    onDismissed:
                                                                        (direction) {
                                                                      controller.deleteItemFromCart(
                                                                          profile
                                                                              .key,
                                                                          session
                                                                              .key,
                                                                          menuDetail
                                                                              .key);
                                                                    },
                                                                    background:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              20.0),
                                                                      color: Colors
                                                                          .redAccent,
                                                                      child: const Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: ThemeColor
                                                                            .itemColor,
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .all(
                                                                          Radius.circular(
                                                                              14),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            100,
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width:
                                                                                  90,
                                                                              height:
                                                                                  90,
                                                                              child:
                                                                                  ClipRRect(
                                                                                borderRadius: const BorderRadius.all(
                                                                                  Radius.circular(12),
                                                                                ),
                                                                                child: CustomNetworkImage(
                                                                                  controller.listMenuDetail[menuDetail.key]!.food!.imagePath!,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child:
                                                                                  Container(
                                                                                padding: const EdgeInsets.only(
                                                                                  left: 15,
                                                                                  right: 15,
                                                                                ),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      child: Text(
                                                                                        controller.listMenuDetail[menuDetail.key]!.food!.name.toString(),
                                                                                        style: Get.textTheme.bodyMedium,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(height: 2),
                                                                                    SizedBox(
                                                                                      child: Text(
                                                                                        'Loại: ${controller.listMenuDetail[menuDetail.key]!.food!.category!.name}',
                                                                                        style: Get.textTheme.bodySmall!.copyWith(color: Colors.black54),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(height: 2),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          Formater.formatMoney(controller.listMenuDetail[menuDetail.key]!.price.toString()),
                                                                                          style: Get.textTheme.bodySmall!.copyWith(color: const Color.fromRGBO(240, 103, 24, 1)),
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        if (controller.listMenuDetail[menuDetail.key]!.price != controller.listMenuDetail[menuDetail.key]!.food!.price)
                                                                                          Text(
                                                                                            Formater.formatMoney(controller.listMenuDetail[menuDetail.key]!.food!.price.toString()),
                                                                                            style: Get.textTheme.bodySmall!.copyWith(decoration: TextDecoration.lineThrough, color: Colors.black54),
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            maxLines: 1,
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(height: 2),
                                                                                    SizedBox(
                                                                                      width: 100,
                                                                                      height: 30,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          GestureDetector(
                                                                                            onTap: () {
                                                                                              if (menuDetail.value.value == 1) {
                                                                                                showDeleteDialog(
                                                                                                  () async {
                                                                                                    await controller.deleteItemFromCart(profile.key, session.key, menuDetail.key);
                                                                                                    Get.back();
                                                                                                  },
                                                                                                );
                                                                                              } else {
                                                                                                controller.decreaseItemCart(profile.key, session.key, menuDetail.key);
                                                                                              }
                                                                                            },
                                                                                            child: const Icon(
                                                                                              Iconsax.minus_square,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 30,
                                                                                            child: Text(
                                                                                              menuDetail.value.toString(),
                                                                                              textAlign: TextAlign.center,
                                                                                              style: Get.textTheme.bodyLarge,
                                                                                            ),
                                                                                          ),
                                                                                          GestureDetector(
                                                                                            onTap: () {
                                                                                              controller.increaseItemCart(profile.key, session.key, menuDetail.key);
                                                                                            },
                                                                                            child: const Icon(
                                                                                              Iconsax.add_square,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    const Spacer(),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                      )
                                                    ],
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Màu của đổ bóng và độ mờ
                    spreadRadius: 5, // Độ lan rộng của đổ bóng
                    blurRadius: 7, // Độ mờ của đổ bóng
                    offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                  ),
                ],
              ),
              height: 60,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20 - 15 - 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Tổng thanh toán',
                            style: TextStyle(fontSize: 14)),
                        Obx(() => Text(
                            Formater.formatMoney(
                                controller.total.value.toString()),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(240, 103, 24, 1),
                                fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 140,
                    child: Obx(
                      () => TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            return Colors.white;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return ThemeColor.textButtonColor;
                          }),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(5)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              // side:
                              //     BorderSide(color: ThemeColor.textButtonColor),
                            ),
                          ),
                        ),
                        onPressed: controller.dataList.isEmpty
                            ? null
                            : () {
                                Get.to(() => const CheckOutDetailScreen());
                              },
                        child: Text(
                          'Đặt hàng',
                          style: Get.textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
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
    );
  }

  Future showDeleteDialog(Function() onPressed) async {
    Get.dialog(AlertDialog(
      title: const Text("Xác nhận"),
      content: const Text(
          "Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?"),
      actions: <Widget>[
        TextButton(onPressed: onPressed, child: const Text("Xoá")),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Huỷ"),
        ),
      ],
    ));
  }
}
