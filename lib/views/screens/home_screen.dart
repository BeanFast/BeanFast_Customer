import 'package:beanfast_customer/views/screens/cart_screen.dart';
import 'package:beanfast_customer/views/screens/menu_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/home_controller.dart';
import '/views/widgets/main_icon_button_widget.dart';
import 'deposit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                  color: Colors.transparent,
                  child: Obx(
                    () => Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            homeController.isMoneyVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            homeController.toggleMoneyVisibility();
                          },
                        ),
                        Text(
                          homeController.moneyValue.value,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MainIconButton(
                              icon: Icons.list_alt_outlined,
                              text: "Đặt hàng",
                              onPressed: () {
                                Get.to(MenuScreen());
                              },
                            ),
                            MainIconButton(
                              icon: Icons.input_outlined,
                              text: "Nạp tiền",
                              onPressed: () {
                                Get.to(DepositeScreen());
                              },
                            ),
                            MainIconButton(
                              icon: Icons.card_giftcard_outlined,
                              text: "Đổi thưởng",
                              onPressed: () {},
                            ),
                            MainIconButton(
                              icon: Icons.gamepad_outlined,
                              text: "Trò chơi",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 150,
                        autoPlayInterval: Duration(seconds: 15),
                      ),
                      items: [
                        // Replace these with your image widgets
                        'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg',
                        'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg',
                        'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg',
                      ].map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                // Handle the tap
                                Get.snackbar(
                                  "SnakeBar Title",
                                  'Image clicked: $imageUrl',
                                  snackPosition: SnackPosition.TOP,
                                );
                              },
                              child: Card(
                                color: Colors.red,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            (MediaQuery.of(context).size.height - 50 - 25) /
                                (4 * 240),
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.snackbar(
                              "SnakeBar Title",
                              'Image clicked:',
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/3486/3486989.png',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Giảm Giá',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Đơn hàng của tôi',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}