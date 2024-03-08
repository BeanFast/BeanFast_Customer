import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/main_controller.dart';
import 'account_screen.dart';
import 'home_screen.dart';
import 'order_preparing_tab.dart';
import 'order_screen.dart';
import 'transaction_screen.dart';

class MainScreen extends GetView<MainController> {
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
