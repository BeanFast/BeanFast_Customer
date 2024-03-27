import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Image.network(
                      'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                      fit: BoxFit.cover),
                ),
                Stack(
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tên sản phẩm\n2',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '150.000',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 16,
                                      color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          216) /
                                      2,
                                  child: const Text(
                                    '150.000đ',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () {
                                    return cartController.quantity.value == 0
                                        ? IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: cartController.increase,
                                          )
                                        : Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed:
                                                    cartController.decrease,
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  width: 20,
                                                  child: Text(
                                                      '${cartController.quantity.value}')),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed:
                                                    cartController.increase,
                                              ),
                                            ],
                                          );
                                  },
                                ),
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
                // const Divider(),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mô tả', style: TextStyle(fontSize: 16)),
                        Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod'),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      7,
                      (index) => GestureDetector(
                        onTap: () {
                          Get.to(const ProductDetailScreen());
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    'Combo Burger + nước ngọt số $index',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          '150.000đ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon:
                                                const Icon(Icons.add_outlined)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class CartController extends GetxController {
  RxInt quantity = 0.obs;

  void increase() {
    quantity.value++;
  }

  void decrease() {
    if (quantity.value >= 1) {
      quantity.value--;
    }
  }

  void addToCart() {}
}
