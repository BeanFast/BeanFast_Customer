import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/controllers/profile_controller.dart';
import '/enums/menu_index_enum.dart';
import '/views/widgets/image_default.dart';
import '/utils/constants.dart';
import '/views/widgets/is_empty.dart';
import '/views/screens/loading_screen.dart';
import '/views/screens/student_detail_screen.dart';
import 'splash_screen.dart';
import 'student_form_screen.dart';

class StudentListScreen extends GetView<ProfileController> {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return LoadingScreen(
        future: controller.getData,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Danh sách học sinh'),
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left_2),
              onPressed: () {
                changePage(MenuIndexState.account.index);
                Get.offAll(const SplashScreen());
              },
            ),
          ),
          body: Column(
            children: [
              Obx(
                () => Expanded(
                  child: controller.listData.isEmpty
                      ? const IsEmptyWidget(title: 'Chưa có học sinh')
                      : SingleChildScrollView(
                          child: Column(
                            children:
                                controller.listData.map((profile) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(StudentDetailScreen(
                                      id: profile.id.toString()));
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CustomNetworkImage(
                                        profile.avatarPath.toString(),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      profile.fullName.toString(),
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      profile.className.toString(),
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Get.to(StudentFormScreen(
                                            profileId: profile.id));
                                      },
                                      icon: const Icon(Iconsax.edit),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                ),
              ),
              Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.5), // Màu của đổ bóng và độ mờ
                      spreadRadius: 5, // Độ lan rộng của đổ bóng
                      blurRadius: 7, // Độ mờ của đổ bóng
                      offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                    ),
                  ],
                ),
                child: SizedBox(
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.to(const StudentFormScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Iconsax.add,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Thêm học sinh',
                          style: Get.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
