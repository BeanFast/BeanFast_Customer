import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/contrains/theme_color.dart';
import '/controllers/auth_controller.dart';
import '/utils/constants.dart';
import '/views/screens/account_profile_screen.dart';
import '/views/screens/home_screen.dart';
import '/views/screens/loading_screen.dart';
import '/views/screens/student_list_screen.dart';
import '/views/widgets/account_icon_button_widget.dart';
import 'game_select_screen.dart';
import 'gift_exchange_screen.dart';

class AccountScreen extends GetView<AuthController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

    // ignore: dead_code
    double topCardheight = 160;
    return LoadingScreen(
      future: () async {
        await controller.getCurrentUser();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Scaffold(
              body: FadeInUp(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: topCardheight + 60,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double innerWidth = constraints.maxWidth;
                              return Obx(
                                () => Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Card(
                                        child: SizedBox(
                                          height: topCardheight,
                                          width: innerWidth,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                currentUser.value!.fullName
                                                    .toString(),
                                                style: Get.textTheme.bodyMedium,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    currentUser.value!.phone
                                                        .toString(),
                                                    style:
                                                        Get.textTheme.bodySmall,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                    Iconsax.tick_circle,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: innerWidth,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                      width: innerWidth / 2 - 5,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Get.to(
                                                              const AccountProfileScreen());
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    ThemeColor
                                                                        .textButtonColor),
                                                            foregroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .black),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10), // Adjust the value as needed
                                                              ),
                                                            ))),
                                                        child: const Text(
                                                            'Trang cá nhân'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      width: innerWidth / 2 - 5,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    ThemeColor
                                                                        .textButtonColor),
                                                            foregroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .black),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10), // Adjust the value as needed
                                                              ),
                                                            ))),
                                                        child: const Text(
                                                            'Giới thiệu app'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: ClipOval(
                                          child: Image.network(
                                            currentUser.value!.avatarPath
                                                .toString(),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Cài đặt",
                          style: Get.textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Card(
                          color: ThemeColor.itemColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const StudentListScreen());
                                  },
                                  child: Container(
                                    color: ThemeColor.itemColor,
                                    child: SettingItem(
                                      title: "Danh sách học sinh",
                                      icon: Iconsax.people,
                                      iconColor: Colors.amber,
                                      onTap: () {
                                        Get.to(const StudentListScreen());
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showProfilesDialog(() {
                                      Get.to(const ExchangeGiftScreen());
                                    });
                                  },
                                  child: Container(
                                    color: ThemeColor.itemColor,
                                    child: SettingItem(
                                      title: "Đổi thưởng",
                                      icon: Iconsax.gift,
                                      iconColor: Colors.red,
                                      onTap: () {
                                        showProfilesDialog(() {
                                          Get.to(const ExchangeGiftScreen());
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showProfilesDialog(() {
                                      Get.back();
                                      Get.to(const GameSelectScreen());
                                    });
                                  },
                                  child: Container(
                                    color: ThemeColor.itemColor,
                                    child: SettingItem(
                                      title: "Trò chơi",
                                      icon: Iconsax.game,
                                      iconColor: Colors.green,
                                      onTap: () {
                                        showProfilesDialog(() {
                                          Get.back();
                                          Get.to(const GameSelectScreen());
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Tiện ích",
                          style: theme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.snackbar('Hệ thống', 'Tiếng việt',
                                        duration: const Duration(seconds: 1),
                                        snackPosition: SnackPosition.TOP);
                                  },
                                  child: Container(
                                    color: ThemeColor.itemColor,
                                    child: SettingItem(
                                      title: "Ngôn ngữ",
                                      icon: Ionicons.earth,
                                      iconColor: ThemeColor.iconColor,
                                      value: "Tiếng việt",
                                      onTap: () {
                                        Get.snackbar('Hệ thống', 'Tiếng việt',
                                            duration:
                                                const Duration(seconds: 1),
                                            snackPosition: SnackPosition.TOP);
                                      },
                                    ),
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Get.snackbar('on Tap', 'Tap',
                                //         snackPosition: SnackPosition.TOP);
                                //   },
                                //   child: Container(
                                //
                                //     child: SettingItem(
                                //       title: "Nút số 2",
                                //       icon: Ionicons.earth,
                                //       iconColor: Colors.red,
                                //       onTap: () {
                                //         Get.snackbar('on Tap', 'Tap',
                                //             snackPosition: SnackPosition.TOP);
                                //       },
                                //     ),
                                //   ),
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Get.snackbar('on Tap', 'Tap',
                                //         snackPosition: SnackPosition.TOP);
                                //   },
                                //   child: Container(
                                //
                                //     child: SettingItem(
                                //       title: "Nút số 3",
                                //       icon: Ionicons.earth,
                                //       iconColor: Colors.red,
                                //       onTap: () {
                                //         Get.snackbar('on Tap', 'Tap',
                                //             snackPosition: SnackPosition.TOP);
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              width: width - 20,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.logOut();
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ThemeColor.textButtonColor),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10), // Adjust the value as needed
                                      ),
                                    ))),
                                child: Text('Đăng xuất',
                                    style: theme.titleSmall!
                                        .copyWith(color: Colors.black)),
                              ),
                            ),
                            // SizedBox(
                            //   height: 40,
                            //   width: width / 2 - 15,
                            //   child: ElevatedButton(
                            //     onPressed: () {},
                            //     style: ButtonStyle(
                            //         backgroundColor:
                            //             MaterialStateProperty.all<Color>(
                            //                 Colors.blue),
                            //         foregroundColor:
                            //             MaterialStateProperty.all<Color>(
                            //                 Colors.white),
                            //         shape: MaterialStateProperty.all<
                            //                 RoundedRectangleBorder>(
                            //             const RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.all(
                            //             Radius.circular(
                            //                 10), // Adjust the value as needed
                            //           ),
                            //         ))),
                            //     child: Text('Đổi tài khoản',
                            //         style: theme.titleSmall!
                            //             .copyWith(color: Colors.white)),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child:
                              Text("Phiên bản 1.0.0", style: theme.bodySmall),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
