import 'package:beanfast_customer/views/screens/checkout_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/auth_controller.dart';
import '/views/screens/loading_screen.dart';
import '/controllers/cart_controller.dart';
import '/contrains/theme_color.dart';
import '/utils/formater.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: LoadingScreen(
        future: controller.getData,
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
              height: 50,
              child: Obx(
                () => Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        authController.isMoneyVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 16,
                      ),
                      onPressed: () {
                        authController.toggleMoneyVisibility();
                      },
                    ),
                    Text(
                      authController.moneyValue.value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => Column(
                    children: controller.listCart.entries.map((profile) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        color: ThemeColor.bgTitleColor,
                                        border: const Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        controller
                                            .listProfile[profile.key]!.fullName
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
                                            .map((session) => Column(
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
                                                          const Text(
                                                              'Mở đặt đến'),
                                                          Text(
                                                            ' ${DateFormat('HH:mm, dd/MM/yyyy').format(controller.listSession[session.key]!.orderEndTime!)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children:
                                                          session.value.entries
                                                              .map(
                                                                (menuDetail) =>
                                                                    Container(
                                                                      margin: const EdgeInsets.only(bottom: 10),
                                                                  decoration: BoxDecoration(
                                                                      color: ThemeColor
                                                                          .itemColor,
                                                                      borderRadius:
                                                                          const BorderRadius.all(
                                                                              Radius.circular(14))),
                                                                  child:
                                                                       SizedBox(
                                                                    height: 125,
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              125,
                                                                          height:
                                                                              125,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              controller.listMenuDetail[menuDetail.key]!.food!.imagePath!,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 10,
                                                                                right: 10,
                                                                                top: 5,
                                                                                bottom: 5),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    controller.listMenuDetail[menuDetail.key]!.food!.name.toString(),
                                                                                    style: const TextStyle(fontSize: 16),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 2),
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    controller.listMenuDetail[menuDetail.key]!.food!.category!.name.toString(),
                                                                                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 2),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      Formater.formatMoney(controller.listMenuDetail[menuDetail.key]!.price.toString()),
                                                                                      style: const TextStyle(fontSize: 16, color: Colors.red),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 1,
                                                                                    ),
                                                                                    const SizedBox(width: 10),
                                                                                    if (controller.listMenuDetail[menuDetail.key]!.price != controller.listMenuDetail[menuDetail.key]!.food!.price)
                                                                                      Text(
                                                                                        Formater.formatMoney(controller.listMenuDetail[menuDetail.key]!.food!.price.toString()),
                                                                                        style: const TextStyle(
                                                                                          fontSize: 16,
                                                                                          decoration: TextDecoration.lineThrough,
                                                                                        ),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                                const SizedBox(height: 2),
                                                                                Container(
                                                                                  width: 124,
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                    border: Border.all(color: Colors.grey),
                                                                                  ),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      IconButton(
                                                                                        color: ThemeColor.iconButtonColor,
                                                                                        onPressed: () => {
                                                                                          controller.decreaseItemCart(profile.key, session.key, menuDetail.key)
                                                                                        },
                                                                                        icon: const Icon(Icons.remove),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 26,
                                                                                        child: Text(
                                                                                          menuDetail.value.toString(),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                      IconButton(
                                                                                        color: ThemeColor.iconButtonColor,
                                                                                        onPressed: () => {
                                                                                          controller.increaseItemCart(profile.key, session.key, menuDetail.key)
                                                                                        },
                                                                                        icon: const Icon(Icons.add),
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
                                                              )
                                                              .toList(),
                                                    )
                                                  ],
                                                ))
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
                                color: Colors.red,
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
                            // if (states.contains(MaterialState.disabled)) {
                            //   return Colors.grey;
                            // }
                            return Colors.white;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Colors.green;
                          }),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(5)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        onPressed: controller.listCart.isEmpty
                            ? null
                            : () {
                                Get.to(const CheckOutDetailScreen());
                              },
                        child: const Text('Đặt hàng',
                            style: TextStyle(fontSize: 18)),
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
}
