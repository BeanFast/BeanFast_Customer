import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/cart_controller.dart';
import '/controllers/auth_controller.dart';
import '/controllers/home_controller.dart';
import '/views/widgets/item_profile_widget.dart';
import '/views/screens/deposit_screen.dart';
import '/views/screens/game_select_screen.dart';
import '/views/widgets/main_icon_button_widget.dart';
import 'cart_screen.dart';
import 'gift_exchange_screen.dart';
import 'loading_screen.dart';
import 'menu_screen.dart';
import 'notification_screen.dart';
import 'student_form_screen.dart';
import '/utils/constants.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    var authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        actions: headerActionWidget(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Card(
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainIconButton(
                                    icon: Icons.list_alt_outlined,
                                    text: "Đặt hàng",
                                    isNew: false,
                                    onPressed: () {
                                      showProfilesDialog(context, () {
                                        // currentUser.value
                                        Get.back();
                                        Get.to(const SessionScreen());
                                      });
                                    },
                                  ),
                                  MainIconButton(
                                    icon: Icons.input_outlined,
                                    text: "Nạp tiền",
                                    // text: "Nạp tiền",
                                    isNew: false,
                                    onPressed: () {
                                      // Get.to(const MyLoadingWidget());
                                      Get.to(DepositeScreen());
                                    },
                                  ),
                                  MainIconButton(
                                    icon: Icons.card_giftcard_outlined,
                                    text: "Đổi thưởng",
                                    isNew: true,
                                    onPressed: () {
                                      showProfilesDialog(context, () {
                                        Get.back();
                                        Get.to(const GiftExchangeScreen());
                                      });
                                    },
                                  ),
                                  MainIconButton(
                                    icon: Icons.gamepad_outlined,
                                    text: "Trò chơi",
                                    isNew: true,
                                    onPressed: () {
                                      showProfilesDialog(context, () {
                                        Get.back();
                                        Get.to(const GameSelectScreen());
                                      });
                                      // Get.to(QRScanScreen());
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 150,
                        autoPlayInterval: const Duration(seconds: 15),
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
                        childAspectRatio: (Get.height - 50 - 25) / (4 * 240),
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
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
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

  void showProfilesDialog(
      BuildContext context, final void Function() onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingScreen(
            future: controller.getProfiles,
            child: AlertDialog(
              title: const Text('Chọn học sinh'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4 + 80,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        child: Card(
                          child: Obx(() => Column(
                                children: controller.listProfile.map((e) {
                                  return ItemProfile(
                                    model: e,
                                    onPressed: () =>
                                        {currentProfile.value = e, onPressed()},
                                  );
                                }).toList(),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Text color
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green), // Background color
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(10.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.to(const StudentFormScreen(isUpdate: false));
                        },
                        child: const Text('Thêm người mới',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

List<Widget> headerActionWidget() {
  Get.put(CartController());
  return <Widget>[
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 50,
          height: 50,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined, size: 30),
              onPressed: () {
                Get.to(const NotificationScreen());
              },
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Positioned(
            top: 5,
            right: 3,
            width: 20,
            height: 20,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    '99+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
        ),
      ],
    ),
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 50,
          height: 50,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, size: 30),
              onPressed: () {
                Get.to(const CartScreen());
              },
            ),
          ),
        ),
        // if (Get.find<CartController>().itemCount.value != 0)
        Obx(
          () => Visibility(
            visible: Get.find<CartController>().itemCount.value != 0,
            child: Positioned(
              top: 5,
              right: 3,
              width: 20,
              height: 20,
              child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      Get.find<CartController>().itemCount.value.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    ),
  ];
}
