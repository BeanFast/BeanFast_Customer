import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/home_controller.dart';
import 'package:beanfast_customer/models/profile.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/widgets/item_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileQRScreen extends StatelessWidget {
  const ProfileQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã QR của bạn'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showProfilesDialog(() {
                  Get.back();
                });
              },
              child: Container(
                width: Get.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: ThemeColor.itemColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        child: Image(
                          image: Image.network(
                                  currentProfile.value.avatarPath.toString())
                              .image,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentProfile.value.fullName.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              currentProfile.value.school!.name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodySmall!.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 24,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: Get.width - 40,
                child: Obx(
                  () => Center(
                    child: QrImageView(
                      data: currentProfile.value.loyaltyCards!.first.qRCode.toString(),
                      version: QrVersions.auto,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileQRController extends GetxController {
  Rx<Profile> currentProfile = Profile().obs;
}

void showProfilesDialog(Function() onPressed) {
  HomeController controller = Get.find<HomeController>();

  Get.dialog(AlertDialog(
    title: const Text('Chọn học sinh'),
    content: LoadingScreen(
      future: controller.getProfiles,
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.5,
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.5,
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listProfile.map((e) {
                      return ItemProfile(
                        model: e,
                        onPressed: () =>
                            {currentProfile.value = e, onPressed()},
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
