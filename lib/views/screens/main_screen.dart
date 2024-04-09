import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/utils/constants.dart';
import 'account_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';
import 'transaction_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const OrderScreen(),
      const TransactionScreen(),
      const AccountScreen()
    ];

    List iconList = [
      Iconsax.home,
      Iconsax.box,
      Iconsax.calendar_tick,
      Iconsax.profile_2user
    ];
    return Scaffold(
      body: Obx(() => screens[selectedMenuIndex.value]),
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar.builder(
          height: 50,
          activeIndex: selectedMenuIndex.value,
          onTap: changePage,
          itemCount: iconList.length,
          tabBuilder: (index, isActive) {
            return Icon(
              iconList[index],
              size: 24,
              color: isActive ? Colors.green : Colors.black54,
            );
          },
          notchMargin: 5,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(const QRScanScreen());
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        backgroundColor: Colors.green.withOpacity(0.5),
        child: const Icon(
          Iconsax.scan_barcode,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
