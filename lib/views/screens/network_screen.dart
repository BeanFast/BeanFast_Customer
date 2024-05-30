import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import '/contains/theme_color.dart';
import '/views/widgets/sbutton.dart';
import 'splash_screen.dart';

class NetworkScreen extends GetView<NetworkController> {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NetworkController());
    return FutureBuilder(
      future: controller.checkConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(
              'assets/images/loading.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          );
        } else if (snapshot.hasError) {
          return const ErrorNetworkScreen(); //Error checking connection'
        } else {
          return Obx(() {
            if (controller.isConnected.value) {
              return const SplashScreen();
            } else {
              return const ErrorNetworkScreen(); //No internet connection
            }
          });
        }
      },
    );
  }
}

class ErrorNetworkScreen extends GetView<NetworkController> {
  const ErrorNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/loading_error.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Text('Mất kết nối mạng. Kiểm tra kết nối và thử lại bạn nhé.',
                    style: Get.textTheme.bodyMedium!),
              ],
            ),
          ),
          Center(
            child: SButton(
                color: ThemeColor.primaryColor,
                borderColor: ThemeColor.primaryColor,
                text: 'Thử lại',
                textStyle: Get.textTheme.titleMedium,
                onPressed: () async {
                  await controller.checkConnection();
                  if(controller.isConnected.value == false){
                    Get.snackbar('Thông báo', 'Không thể kết nối mạng. Vui lòng kiểm tra lại kết nối mạng của bạn.');
                  }
                }),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class NetworkController extends GetxController {
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
    } else {
      isConnected.value = false;
    }
  }
}
