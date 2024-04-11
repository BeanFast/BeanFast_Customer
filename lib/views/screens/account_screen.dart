import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:beanfast_customer/views/screens/account_profile_screen.dart';
import 'package:beanfast_customer/views/screens/home_screen.dart';
import 'package:beanfast_customer/views/screens/student_list_screen.dart';
import 'package:beanfast_customer/views/widgets/account_icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'game_select_screen.dart';
import 'gift_exchange_screen.dart';

class AccountScreen extends GetView<AuthController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool randomBool = Random().nextBool();
    bool isValid = true;
    double topCardheight = isValid ? 160 : 340;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(),
        ),
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
                            return Stack(
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
                                            currentUser.value.fullName!,
                                            style: Get.textTheme.bodyMedium,
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                currentUser.value.phone!,
                                                style: Get.textTheme.bodySmall,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: isValid
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                  child: Container(
                                                    child: isValid
                                                        ? Text(
                                                            'Đã xác thực',
                                                            style: Get.textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : const Text(
                                                            'Chưa xác thực',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          if (!isValid)
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Card(
                                                child: Container(
                                                  height: 170,
                                                  width: innerWidth - 40,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.network(
                                                            'https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png',
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            width: innerWidth -
                                                                160,
                                                            height: 100,
                                                            child: const Column(
                                                              children: [
                                                                Text(
                                                                  'Yêu cầu bổ sung CMND/CCCD để xác thực tài khoản',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  'Bắc buộc để sử dụng các dịch vụ của chúng tôi',
                                                                  maxLines: 4,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      SizedBox(
                                                        height: 40,
                                                        width: innerWidth,
                                                        child: ElevatedButton(
                                                          onPressed: () {},
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .blue),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ))),
                                                          child: const Text(
                                                              'Xác nhận thông tin'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
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
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .blue),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
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
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .blue),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
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
                                        currentUser.value.avatarPath!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                  Get.back();
                                  Get.to(const GiftExchangeScreen());
                                });
                              },
                              child: Container(
                                color: ThemeColor.itemColor,
                                child: SettingItem(
                                  title: "Đổi thưởng",
                                  icon: Ionicons.earth,
                                  iconColor: Colors.red,
                                  onTap: () {
                                    showProfilesDialog(() {
                                      Get.back();
                                      Get.to(const GiftExchangeScreen());
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
                                  icon: Ionicons.earth,
                                  iconColor: Colors.red,
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
                      const SizedBox(height: 20),
                      Text(
                        "Tiện ích",
                        style: theme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.snackbar('on Tap', 'Tap',
                                    snackPosition: SnackPosition.TOP);
                              },
                              child: Container(
                                color: ThemeColor.itemColor,
                                child: SettingItem(
                                  title: "Ngôn ngữ",
                                  icon: Ionicons.earth,
                                  iconColor: Colors.red,
                                  value: "English",
                                  onTap: () {
                                    Get.snackbar('on Tap', 'Tap',
                                        snackPosition: SnackPosition.TOP);
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.snackbar('on Tap', 'Tap',
                                    snackPosition: SnackPosition.TOP);
                              },
                              child: Container(
                                color: ThemeColor.itemColor,
                                child: SettingItem(
                                  title: "Nút số 2",
                                  icon: Ionicons.earth,
                                  iconColor: Colors.red,
                                  onTap: () {
                                    Get.snackbar('on Tap', 'Tap',
                                        snackPosition: SnackPosition.TOP);
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.snackbar('on Tap', 'Tap',
                                    snackPosition: SnackPosition.TOP);
                              },
                              child: Container(
                                color: ThemeColor.itemColor,
                                child: SettingItem(
                                  title: "Nút số 3",
                                  icon: Ionicons.earth,
                                  iconColor: Colors.red,
                                  onTap: () {
                                    Get.snackbar('on Tap', 'Tap',
                                        snackPosition: SnackPosition.TOP);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                            width: width / 2 - 15,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.logOut();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
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
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: width / 2 - 15,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
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
                              child: Text('Đổi tài khoản',
                                  style: theme.titleSmall!
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Phiên bản 1.0.0", style: theme.bodySmall),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
