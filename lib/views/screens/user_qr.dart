import 'dart:async';
import 'package:beanfast_customer/views/screens/data_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/models/profile.dart';
import '/models/qrcode.dart';
import '/contains/theme_color.dart';
import '/services/user_service.dart';
import '/views/screens/loading_screen.dart';
import '/utils/logger.dart';

class UserQRScreen extends GetView<ProfileQRController> {
  const UserQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileQRController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã QR của bạn'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              LoadingScreen(
                future: controller.generateQRData,
                child: Obx(
                  () => DataScreen(
                    hasData: controller.qrData.value != null ? true : false,
                    message: 'Chưa có dữ liệu',
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      width: Get.width - 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đưa mã này cho nhân viên',
                            style: Get.textTheme.bodyLarge!
                                .copyWith(color: Colors.black54),
                          ),
                          QrImageView(
                            data: controller.qrData.value.toString(),
                            version: QrVersions.auto,
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Tự động cập nhật sau: ${controller.qrExpiration.value}s',
                                    style: Get.textTheme.bodyMedium),
                                if (int.parse(controller.qrExpiration.value) <=
                                    55)
                                  TextButton(
                                    onPressed: () async {
                                      await controller.generateQRData();
                                    },
                                    child: Text(
                                      'Cập nhật',
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                          color: ThemeColor.textButtonColor),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileQRController extends GetxController {
  Rx<Profile> currentProfile = Profile().obs;
  Rx<String?> qrData = Rx<String?>(null);
  RxString qrExpiration = ''.obs;
  Timer? timer;

  Future generateQRData() async {
    try {
      UserQrCode userQrCode = await UserService().updateQRCode();
      qrData.value = userQrCode.qrCode.toString();
      logger.e(qrData.value);
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
    timer?.cancel();
    int expireTime = 59;
    qrExpiration.value = expireTime.toString();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      if (expireTime > 0) {
        expireTime--;
        qrExpiration.value = expireTime.toString();
      } else {
        t.cancel();
        await generateQRData();
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
