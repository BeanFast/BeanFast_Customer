import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../enums/menu_index_enum.dart';
import '/controllers/auth_controller.dart';
import '/utils/constants.dart';
import '/views/widgets/is_empty.dart';
import '/views/screens/loading_screen.dart';
import '/views/screens/student_detail_screen.dart';
import 'splash_screen.dart';
import 'student_form_screen.dart';

class StudentListScreen extends GetView<AuthController> {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileController());
    return LoadingScreen(
        future: controller.getCurrentUser,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Danh sách học sinh'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                changePage(MenuIndexState.account.index);
                Get.off(const SplashScreen());
              },
            ),
          ),
          body: Column(
            children: [
              Obx(
                () => Expanded(
                  child: currentUser.value!.profiles!.isEmpty
                      ? const IsEmptyWidget(title: 'Chưa có học sinh')
                      : SingleChildScrollView(
                          child: Column(
                            children:
                                currentUser.value!.profiles!.map((profile) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(StudentDetailScreen(
                                      id: profile.id.toString()));
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              profile.avatarPath.toString()),
                                          fit: BoxFit.cover,
                                        ),
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
