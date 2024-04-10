import 'package:beanfast_customer/controllers/profile_controller.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.listData.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(StudentDetailScreen(id: e.id.toString()));
                          },
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(e.avatarPath.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                e.fullName.toString(),
                                style: Get.textTheme.bodyLarge,
                              ),
                              subtitle: Text(
                                e.className.toString(),
                                style: Get.textTheme.bodySmall,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Get.to(
                                      const StudentFormScreen(isUpdate: true));
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
                      Get.to(const StudentFormScreen(isUpdate: false));
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
