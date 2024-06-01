import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/profile_controller.dart';
import '/controllers/auth_controller.dart';
import '/enums/auth_state_enum.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';
import 'error_screen.dart';
import 'main_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends GetView<AuthController> {
  const SplashScreen({super.key});

  Future<void> initializeSettings() async {
    logger.w('initializeSettings');
    controller.checkLoginStatus();
    if (authState.value == AuthState.authenticated) {
      await controller.getUser();
      await Get.put(ProfileController()).getCurrentProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          return Obx(() {
            switch (authState.value) {
              case AuthState.authenticated:
                return const MainScreen();
              case AuthState.unauthenticated:
                return const OnBoardingPage();
              default:
                return const ErrorScreen(message: 'Lỗi xác thực đăng nhập');
            }
          });
          // }
        }
      },
    );
  }

  Scaffold waitingView() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
