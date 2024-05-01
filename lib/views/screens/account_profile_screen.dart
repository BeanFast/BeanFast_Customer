import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';

import '/controllers/auth_controller.dart';
import '/controllers/user_controller.dart';
import '/contains/theme_color.dart';
import '/utils/constants.dart';
import '/views/screens/loading_screen.dart';
import '/views/screens/student_list_screen.dart';

class AccountProfileScreen extends GetView<UserController> {
  const AccountProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    AuthController authController = Get.put(AuthController());
    return LoadingScreen(
      future: () async {
        await authController.getCurrentUser();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  Container(
                    height: Get.height,
                    color: ThemeColor.primaryColor.withOpacity(0.3),
                  ),
                  Positioned(
                    top: 70,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Iconsax.arrow_left_2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Obx(() => Text(
                        currentUser.value!.fullName == null
                            ? 'Chưa có thông tin'
                            : currentUser.value!.fullName.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    currentUser.value!.phone.toString(),
                    style: Get.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: ThemeColor.iconColor,
                      child: Obx(() => CircleAvatar(
                            radius: 68,
                            backgroundImage: Image.network(
                                    currentUser.value!.avatarPath.toString())
                                .image,
                          )),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 80,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 15),
                          color: Colors.black,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                    right: 10,
                                    left: 10,
                                  ),
                                  child: Wrap(
                                    children: <Widget>[
                                      SizedBox(
                                        child: Center(
                                          child: Text(
                                            "Lựa chọn phương thức",
                                            style: Get.textTheme.titleLarge,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(Iconsax.camera),
                                        title: const Text('Chụp ảnh'),
                                        onTap: () async {
                                          controller.pickPhotoFormCamera();
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Iconsax.gallery_add),
                                        title: const Text(
                                            'Chọn ảnh từ thư viện ảnh'),
                                        onTap: () async {
                                          controller.pickPhotoFormStorage();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInUp(
              child: Container(
                margin: const EdgeInsets.only(top: 370),
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                height: MediaQuery.of(context).size.height - 360,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        child: ListTile(
                          leading: const Icon(Iconsax.personalcard),
                          title: const Text('Tên'),
                          subtitle: Obx(() => Text(
                                currentUser.value!.fullName == null
                                    ? 'Chưa có thông tin'
                                    : currentUser.value!.fullName.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.edit),
                            onPressed: () {
                              showDialog();
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const StudentListScreen());
                        },
                        child: Card(
                          child: ListTile(
                            leading: const Icon(Icons.child_care),
                            title: const Text('Số học sinh'),
                            subtitle: Obx(() => Text(currentUser
                                .value!.profiles!.length
                                .toString())),
                            trailing: IconButton(
                                icon: const Icon(Iconsax.arrow_right_3),
                                onPressed: () =>
                                    Get.to(const StudentListScreen())),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialog() {
    controller.imagePath.value = '';
    if (currentUser.value!.fullName != null) {
      controller.fullnameController.text = currentUser.value!.fullName!;
    }
    Get.dialog(
      Form(
        key: controller.formKey,
        child: AlertDialog(
          title: Text(
            'Cập nhật tên',
            style: Get.textTheme.bodyLarge,
          ),
          content: TextFormField(
            controller: controller.fullnameController,
            decoration: InputDecoration(
              hintText: currentUser.value!.fullName == null
                  ? ''
                  : currentUser.value!.fullName.toString(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập họ và tên';
              }
              return null;
            },
          ),
          actions: [
            TextButton(
              child: const Text('Huỷ'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Cập nhật'),
              onPressed: () async {
                Get.back();
                await controller.submitForm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
