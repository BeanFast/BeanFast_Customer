import 'package:beanfast_customer/views/screens/cart_screen.dart';
import 'package:beanfast_customer/views/screens/gift_exchange_screen.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/screens/menu_screen.dart';
import 'package:beanfast_customer/views/screens/notification_screen.dart';
import 'package:beanfast_customer/views/screens/qr_scanner_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/profile.dart';
import '/controllers/home_controller.dart';
import '/views/widgets/main_icon_button_widget.dart';
import 'deposit_screen.dart';
import 'student_form_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
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
              Positioned(
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
              Positioned(
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
            ],
          ),
        ],
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
                                      showUserDialogForMenu(context);
                                      // Get.to(MenuScreen());
                                    },
                                  ),
                                  MainIconButton(
                                    icon: Icons.input_outlined,
                                    text: "Nạp tiền",
                                    isNew: false,
                                    onPressed: () {
                                      Get.to(DepositeScreen());
                                    },
                                  ),
                                  MainIconButton(
                                    icon: Icons.card_giftcard_outlined,
                                    text: "Đổi thưởng",
                                    isNew: true,
                                    onPressed: () {
                                      showUserDialogForGiftExchange(context);
                                    },
                                  ),
                                  MainIconButton(
                                    icon: Icons.gamepad_outlined,
                                    text: "Trò chơi",
                                    isNew: true,
                                    onPressed: () {
                                      Get.to(QRScanScreen());
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
                                        controller.isMoneyVisible.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        controller.toggleMoneyVisibility();
                                      },
                                    ),
                                    Text(
                                      controller.moneyValue.value,
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

  void showUserDialogForMenu(BuildContext context) {
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
                                  return ItemProfile(model: e);
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
                          Get.to(StudentFormScreen());
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

class ItemProfile extends StatelessWidget {
  final Profile model;

  const ItemProfile({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(const MenuScreen(
              schoolId: 'b254a297-cae1-4d26-afe2-b093227ded0a',
            ));
          },
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(model.fullName.toString()),
            subtitle: Text(model.school!.name.toString()),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

void showUserDialogForGiftExchange(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Chọn người đổi quà'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: SingleChildScrollView(
            child: Card(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(const GiftExchangeScreen());
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Nguyễn Huỳnh Phi'),
                      subtitle: Text('Điểm: 120.000'),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Get.to(const GiftExchangeScreen());
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Nguyễn Huỳnh Phi'),
                      subtitle: Text('Điểm: 120.000'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const GiftExchangeScreen());
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Nguyễn Huỳnh Phi'),
                      subtitle: Text('Điểm: 120.000'),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Get.to(const GiftExchangeScreen());
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Nguyễn Huỳnh Phi'),
                      subtitle: Text('Điểm: 120.000'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
