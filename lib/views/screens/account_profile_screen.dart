import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/screens/student_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:introduction_screen/introduction_screen.dart';

class AccountProfileScreen extends GetView<AuthController> {
  const AccountProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      future: controller.getCurrentUser,
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
                  Text(
                    currentUser.value!.fullName.toString() == 'null'
                        ? 'Trống'
                        : currentUser.value!.fullName.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                      child: CircleAvatar(
                        radius: 68,
                        backgroundImage: Image.network(
                                currentUser.value!.avatarPath.toString())
                            .image,
                      ),
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
                                                        style: Get.textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Iconsax.camera),
                                                    title:
                                                        const Text('Chụp ảnh'),
                                                    onTap: () async {
                                                      controller
                                                          .pickPhotoFormCamera();
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Iconsax.gallery_add),
                                                    title: const Text(
                                                        'Chọn ảnh từ thư viện ảnh'),
                                                    onTap: () async {
                                                      controller
                                                          .pickPhotoFormStorage();
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
                          subtitle: Text(
                            currentUser.value!.fullName.toString() == 'null'
                                ? 'Trống'
                                : currentUser.value!.fullName.toString(),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Cập nhật tên',
                                      style: Get.textTheme.bodyLarge,
                                    ),
                                    content: TextField(
                                      decoration: InputDecoration(
                                        hintText: currentUser.value!.fullName
                                                    .toString() ==
                                                'null'
                                            ? ''
                                            : currentUser.value!.fullName
                                                .toString(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Huỷ'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Cập nhật'),
                                        onPressed: () {
                                          // Perform the update logic here
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
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
                            subtitle: const Text(
                              '5',
                            ),
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
}
