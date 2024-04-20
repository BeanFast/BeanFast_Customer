import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/screens/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
                    // Lottie.asset(
                    //   "assets/account_banner.json",
                    //   animate: true,
                    //   fit: BoxFit.cover,
                    // ),
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
                    currentUser.value!.fullName.toString(),
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
              child: CircleAvatar(
                radius: 70,
                backgroundColor: ThemeColor.iconColor,
                child: CircleAvatar(
                  radius: 68,
                  backgroundImage:
                      Image.network(currentUser.value!.avatarPath.toString())
                          .image,
                  backgroundColor: Colors.red,
                ),
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
                          subtitle:
                              Text(currentUser.value!.fullName.toString()),
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
