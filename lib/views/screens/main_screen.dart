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
    return Scaffold(
      body: Obx(() => screens[selectedMenuIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: selectedMenuIndex.value,
          onTap: changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.box),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.calendar_tick),
              label: 'Giao dịch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_2user),
              label: 'Tôi',
            ),
          ],
          unselectedItemColor: Colors.black54,
        ),
      ),
    );
  }
}
