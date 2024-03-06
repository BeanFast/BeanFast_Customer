import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Screen1(),
      const Screen2(),
      const Screen3(),
      const Screen4()
    ];
    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: 'Giao dịch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Tôi',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeController extends GetxController {
  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* VND'.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value =
        isMoneyVisible.value ? '70.967.000.000 VND' : '********* VND';
  }
}

class Screen2Controller extends GetxController {
  // Controller cho màn hình 2
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle the icon tap here
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                // Handle the icon tap here
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
                            style: TextStyle(
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
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: GridView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.home_outlined,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Theo dỗi đơn hàng",
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              );
                            },
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
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
        ));
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: const Center(
        child: Text('Screen 2 Content'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: const Center(
        child: Text('Screen 2 Content'),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: const Center(
        child: Text('Screen 2 Content'),
      ),
    );
  }
}
