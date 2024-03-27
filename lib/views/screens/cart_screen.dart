import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/contrains/theme_color.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    var authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Màu của đổ bóng và độ mờ
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: ThemeColor.bgColor1,
                child: Column(
                  children: List.generate(
                      2,
                      (index) => Container(
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
                                    ' Profile number $index',
                                    style: Get.textTheme.titleMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: List.generate(
                                      2,
                                      (index) => Card(
                                        child: SizedBox(
                                          height: 125,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 125,
                                                height: 125,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  12)),
                                                  child: Image.network(
                                                    'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                          'Nước ngọt số $index Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số Nước ngọt số',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      SizedBox(
                                                        child: Text(
                                                          'Loại: $index',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            '150.000',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.red),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            '150.000',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Container(
                                                        width: 124,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            IconButton(
                                                              color: ThemeColor
                                                                  .iconButtonColor,
                                                              onPressed: () =>
                                                                  cartController
                                                                      .decrease(
                                                                          index
                                                                              .toString()),
                                                              icon: const Icon(
                                                                  Icons.remove),
                                                            ),
                                                            Obx(
                                                              () => SizedBox(
                                                                width: 26,
                                                                child: Text(
                                                                  '${cartController.quantities[index.toString()] ?? 0}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            IconButton(
                                                              color: ThemeColor
                                                                  .iconButtonColor,
                                                              onPressed: () =>
                                                                  cartController
                                                                      .increase(
                                                                          index
                                                                              .toString()),
                                                              icon: const Icon(
                                                                  Icons.add),
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
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Màu của đổ bóng và độ mờ
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng thanh toán: ', style: TextStyle(fontSize: 14)),
                      Text('100.000.000 đ',
                          style: TextStyle(fontSize: 14, color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(width: 10),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child:
                        const Text('Mua hàng', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartController extends GetxController {
  RxMap<String, int> quantities = <String, int>{}.obs;

  void increase(String itemId) {
    if (quantities[itemId] != null) {
      quantities.update(itemId, (value) => value + 1);
    } else {
      quantities[itemId] = 1;
    }
  }

  void decrease(String itemId) {
    if (quantities[itemId] != null && quantities[itemId]! > 1) {
      quantities.update(itemId, (value) => value - 1);
    }
  }

  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* đ'.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value =
        isMoneyVisible.value ? '70.967.000.000 đ' : '********* đ';
  }
}
