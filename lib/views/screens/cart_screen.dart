import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng', style: TextStyle(fontSize: 30)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Get.to(const CartScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png'), // Replace with your asset path
                        radius: 30,
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nguyễn Huỳnh Phi'),
                          Text('0966324244'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              Obx(
                () => Container(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            cartController.isMoneyVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            cartController.toggleMoneyVisibility();
                          },
                        ),
                        Text(
                          cartController.moneyValue.value,
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
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        2,
                        (index) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(' Profile number $index'),
                                      Column(
                                        children: List.generate(
                                          2,
                                          (index) => Card(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child: Image.network(
                                                          'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 100,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                top: 10,
                                                                right: 10,
                                                                bottom: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  300,
                                                              child: Text(
                                                                'Nước ngọt số $index',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  300,
                                                              child: const Text(
                                                                '150.000',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .red),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () =>
                                                              cartController
                                                                  .decrease(index
                                                                      .toString()),
                                                          icon: const Icon(
                                                              Icons.remove),
                                                          iconSize: 20,
                                                        ),
                                                        Obx(
                                                          () => SizedBox(
                                                            width: 20,
                                                            child: Text(
                                                              '${cartController.quantities[index.toString()] ?? 0}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () =>
                                                              cartController
                                                                  .increase(index
                                                                      .toString()),
                                                          icon: const Icon(
                                                              Icons.add),
                                                          iconSize: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20 - 15 - 140,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thành tiền: ', style: TextStyle(fontSize: 14)),
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
                        const Text('Đặt hàng', style: TextStyle(fontSize: 18)),
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
