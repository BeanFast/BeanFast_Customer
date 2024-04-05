import 'package:beanfast_customer/controllers/profile_controller.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  child: Card(
              
                    child: Obx(
                      () => Column(
                        children: controller.listData.map((e) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(StudentDetailScreen(id: e.id.toString()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                //  color: index % 2 == 0 ? Colors.white : Colors.grey[300],
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                  e.fullName.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                subtitle: Text(e.className.toString()),
                                trailing: IconButton(
                                  onPressed: () {
                                    Get.snackbar('title', '222',
                                        snackPosition: SnackPosition.TOP);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 10),
                        Text('Thêm học sinh', style: TextStyle(fontSize: 18)),
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
