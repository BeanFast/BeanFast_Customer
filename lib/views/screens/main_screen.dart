import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/utils/constants.dart';
import 'account_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';
import 'transaction_screen.dart';
import '/contains/theme_color.dart';
import 'user_qr.dart';

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
      resizeToAvoidBottomInset: false,
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
              color: isActive ? ThemeColor.textButtonColor : Colors.black54,
            );
          },
          notchMargin: 5,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const UserQRScreen());
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        backgroundColor: ThemeColor.textButtonColor.withOpacity(1),
        child: const Icon(
          Iconsax.scan_barcode,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
