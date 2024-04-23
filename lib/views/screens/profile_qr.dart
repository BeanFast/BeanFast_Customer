import 'dart:async';

import 'package:beanfast_customer/controllers/home_controller.dart';
import 'package:beanfast_customer/views/widgets/item_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '/contrains/theme_color.dart';
import '/models/profile.dart';
import '/utils/constants.dart';
import '/views/screens/loading_screen.dart';

class ProfileQRScreen extends StatelessWidget {
  const ProfileQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileQRController controller = Get.put(ProfileQRController());
    // AuthController authController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã QR của bạn'),
      ),
      body: Center(
        child: LoadingScreen(
          future: () async {
            await Get.find<HomeController>().getProfiles();
          },
          child: currentProfile.value == null
              ? const Text('Chưa có học sinh')
              : Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     showProfilesDialog(() {
                    //       controller.generateQRData();
                    //     });
                    //   },
                    //   child: Container(
                    //     width: Get.width - 20,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(14),
                    //       color: ThemeColor.itemColor,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.5),
                    //           spreadRadius: 1,
                    //           blurRadius: 7,
                    //           offset: const Offset(0, 3),
                    //         ),
                    //       ],
                    //       border: Border.all(
                    //         color: ThemeColor.textButtonColor,
                    //       ),
                    //     ),
                    //     padding: const EdgeInsets.all(10),
                    //     child: Obx(
                    //       () => Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(50),
                    //             ),
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(50),
                    //               child: Image(
                    //                 image: Image.network(currentProfile
                    //                         .value!.avatarPath
                    //                         .toString())
                    //                     .image,
                    //                 width: 40,
                    //                 height: 40,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 7,
                    //           ),
                    //           Expanded(
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   currentProfile.value!.fullName.toString(),
                    //                   maxLines: 1,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: Get.textTheme.bodyMedium!.copyWith(
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   currentProfile.value!.school!.name
                    //                       .toString(),
                    //                   maxLines: 1,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: Get.textTheme.bodySmall!.copyWith(
                    //                     color: Colors.grey,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           const Icon(
                    //             Icons.keyboard_arrow_down,
                    //             size: 20,
                    //             color: Colors.black,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Expanded(
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
                            Obx(
                              () => QrImageView(
                                embeddedImage: const NetworkImage(
                                  'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745',
                                ),
                                data: controller.qrData.value.toString(),
                                version: QrVersions.auto,
                              ),
                            ),
                            Obx(
                              () => SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Tự động cập nhật sau: ${controller.qrExpiration.value}s',
                                        style: Get.textTheme.bodyMedium),
                                    if (int.parse(
                                            controller.qrExpiration.value) <=
                                        55)
                                      TextButton(
                                        onPressed: () {
                                          controller.generateQRData();
                                        },
                                        child: Text(
                                          'Cập nhật',
                                          style: Get.textTheme.bodyLarge!
                                              .copyWith(
                                                  color: ThemeColor
                                                      .textButtonColor),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            // Obx(
                            //   () => Text(
                            //     'Mã QR của bạn: ${controller.qrData.value}',
                            //     style: Get.textTheme.bodyMedium!.copyWith(),
                            //   ),
                            // ),
                          ],
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
  RxString qrData = ''.obs;
  RxString qrExpiration = ''.obs;
  Timer? timer;

  void generateQRData() {
    timer?.cancel();
    qrData.value = Uuid().v4(); // Generate a new UUID
    qrExpiration.value = '59';
    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();

    int expireTime = 59;
    qrExpiration.value = expireTime.toString();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (expireTime > 0) {
        expireTime--;
        qrExpiration.value = expireTime.toString();
      } else {
        t.cancel();
        generateQRData();
      }
    });
  }

  @override
  void onInit() {
    generateQRData();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}

void showProfilesDialog(Function() onPressed) {
  HomeController controller = Get.find<HomeController>();

  Get.dialog(AlertDialog(
    title: const Text('Chọn học sinh'),
    content: LoadingScreen(
      future: controller.getProfiles,
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.4,
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.4,
              child: SingleChildScrollView(
                child: Obx(() => Column(
                      children: controller.listProfile.map((e) {
                        return ItemProfile(
                          model: e,
                          onPressed: () => {
                            currentProfile.value = e,
                            Get.back(),
                            onPressed(),
                          },
                        );
                      }).toList(),
                    )),
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
