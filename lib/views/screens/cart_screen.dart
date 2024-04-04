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
                child: Container(
                  color: ThemeColor.bgColor1,
                  child: Obx(
                    () => Column(
                      children: controller.listCart.entries.map((profile) {
                        return Card(
                          color: ThemeColor.bgColor,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 10),
                                height: 50,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: ThemeColor.bgTitleColor,
                                  border: const Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  controller.listProfile[profile.key]!.fullName
                                      .toString(),
                                  style: Get.textTheme.titleMedium,
                                ),
                              ),
                              Column(
                                children: profile.value.entries
                                    .map((session) => Column(
                                          children: [
                                            Text(DateFormat('dd/MM/yyyy')
                                                .format(controller
                                                    .listSession[session.key]!
                                                    .orderStartTime!)),
                                            Column(
                                              children: session.value.entries
                                                  .map(
                                                    (menuDetail) => SizedBox(
                                                      height: 125,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 125,
                                                            height: Get.height,
                                                            child: ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          12)),
                                                              child:
                                                                  Image.network(
                                                                controller
                                                                    .listMenuDetail[
                                                                        menuDetail
                                                                            .key]!
                                                                    .food!
                                                                    .imagePath!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    child: Text(
                                                                      controller
                                                                          .listMenuDetail[
                                                                              menuDetail.key]!
                                                                          .food!
                                                                          .name
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          2),
                                                                  SizedBox(
                                                                    child: Text(
                                                                      controller
                                                                          .listMenuDetail[
                                                                              menuDetail.key]!
                                                                          .food!
                                                                          .category!
                                                                          .name
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          2),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        Formater.formatMoney(controller
                                                                            .listMenuDetail[menuDetail.key]!
                                                                            .price
                                                                            .toString()),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.red),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      if (controller
                                                                              .listMenuDetail[menuDetail
                                                                                  .key]!
                                                                              .price !=
                                                                          controller
                                                                              .listMenuDetail[menuDetail.key]!
                                                                              .food!
                                                                              .price)
                                                                        Text(
                                                                          Formater.formatMoney(controller
                                                                              .listMenuDetail[menuDetail.key]!
                                                                              .food!
                                                                              .price
                                                                              .toString()),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                          ),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          2),
                                                                  Container(
                                                                    width: 124,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        IconButton(
                                                                          color:
                                                                              ThemeColor.iconButtonColor,
                                                                          onPressed:
                                                                              () => {
                                                                            controller.decreaseItemCart(
                                                                                profile.key,
                                                                                session.key,
                                                                                menuDetail.key)
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.remove),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              26,
                                                                          child:
                                                                              //   Obx(
                                                                              // () =>
                                                                              Text(
                                                                            menuDetail.value.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                          // ),
                                                                        ),
                                                                        IconButton(
                                                                          color:
                                                                              ThemeColor.iconButtonColor,
                                                                          onPressed:
                                                                              () => {
                                                                            controller.increaseItemCart(
                                                                                profile.key,
                                                                                session.key,
                                                                                menuDetail.key)
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.add),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            )
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tổng thanh toán: ',
                            style: TextStyle(fontSize: 14)),
                        Obx(() => Text(
                            Formater.formatMoney(
                                controller.total.value.toString()),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.red))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 40,
                    width: 140,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green), // Background color
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
                      onPressed: () {},
                      child: const Text('Mua hàng',
                          style: TextStyle(fontSize: 18)),
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
