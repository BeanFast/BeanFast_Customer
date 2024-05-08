import 'package:beanfast_customer/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';

import '../../contains/theme_color.dart';
import '/controllers/user_controller.dart';
import '/utils/constants.dart';
import '/views/screens/loading_screen.dart';

class AccountProfileScreen extends GetView<UserController> {
  const AccountProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        future: controller.fetchData,
        messageNoData: 'Chưa có dữ liệu',
        child: Stack(
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
                    top: 50,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
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
                          onPressed: showUpdateAvatarDialog,
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
                              showUpdateNameDialog();
                            },
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

  void showUpdateAvatarDialog() {
    Get.bottomSheet(
      Container(
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
                Get.back();
                await controller.pickPhoto(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.gallery_add),
              title: const Text('Chọn ảnh từ thư viện ảnh'),
              onTap: () async {
                Get.back();
                await controller.pickPhoto(source: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
      backgroundColor: ThemeColor.bgColor,
      elevation: 10,
    );
  }

  void showUpdateNameDialog() {
    controller.createForm();
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
