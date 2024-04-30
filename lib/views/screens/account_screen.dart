import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/views/widgets/image_default.dart';
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
                                                currentUser.value!.fullName.toString() == 'null' ? 'Trống' : currentUser.value!.fullName.toString(),
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
                                          child: CustomNetworkImage(
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
                          "Tiện ích",
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
                                      iconColor: Colors.black,
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
                                      iconColor: Colors.black,
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
                                      iconColor: Colors.black,
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
                          "Cài đặt",
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
                                    ruleDialog(context);
                                  },
                                  child: Container(
                                    color: ThemeColor.itemColor,
                                    child: SettingItem(
                                      title: "Điều khoản sử dụng",
                                      icon: Iconsax.book,
                                      iconColor: Colors.black,
                                      onTap: () {
                                        ruleDialog(context);
                                      },
                                    ),
                                  ),
                                ),
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
                                      iconColor: Colors.black,
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
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '© ${DateTime.now().year} Beanfast',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
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

  Future<dynamic> ruleDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Điều khoản sử dụng'),
          content: SizedBox(
            height: Get.height / 2,
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Mục đích:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nỨng dụng này được tạo ra nhằm mục đích cung cấp dịch vụ đặt đồ ăn sáng tiện lợi cho phụ huynh học sinh. Ứng dụng giúp phụ huynh dễ dàng đặt mua đồ ăn sáng cho con em mình từ các nhà cung cấp uy tín, đảm bảo vệ sinh an toàn thực phẩm.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nĐối tượng sử dụng:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(text: '\nQuyền:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text: '\nTạo tài khoản và sử dụng ứng dụng miễn phí.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nTìm kiếm và lựa chọn nhà cung cấp, món ăn sáng phù hợp cho con em mình.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nĐặt mua đồ ăn sáng, thanh toán trực tuyến an toàn.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nTheo dõi đơn hàng và nhận thông báo trạng thái đơn hàng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nĐánh giá nhà cung cấp và chất lượng dịch vụ.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGửi phản hồi, góp ý cho nhà cung cấp và nhà phát triển ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNghĩa vụ:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nCung cấp thông tin chính xác, đầy đủ khi tạo tài khoản và sử dụng ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nThanh toán đầy đủ cho các đơn hàng đã đặt mua.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nSử dụng ứng dụng đúng mục đích, tuân thủ các quy định của ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nGiữ gìn bí mật thông tin tài khoản cá nhân.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChịu trách nhiệm cho mọi hành vi sử dụng tài khoản của mình.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nQuyền và nghĩa vụ của nhà cung cấp:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(text: '\nQuyền:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text:
                            '\nĐăng ký tài khoản và cung cấp thông tin về nhà cung cấp, thực đơn món ăn sáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNhận đơn hàng từ phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChế biến và giao đồ ăn sáng đúng thời gian, đảm bảo vệ sinh an toàn thực phẩm.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNhận thanh toán cho các đơn hàng đã bán.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nĐánh giá phản hồi của phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGửi phản hồi, góp ý cho nhà phát triển ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNghĩa vụ:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text:
                            '\nCung cấp thông tin chính xác, đầy đủ về nhà cung cấp, thực đơn món ăn sáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nĐảm bảo chất lượng vệ sinh an toàn thực phẩm cho các món ăn sáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGiao đồ ăn sáng đúng thời gian, địa điểm theo yêu cầu của phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChịu trách nhiệm cho chất lượng sản phẩm và dịch vụ cung cấp.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGiải quyết khiếu nại của phụ huynh học sinh một cách thỏa đáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nQuyền và nghĩa vụ của nhà phát triển ứng dụng:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(text: '\nQuyền:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text: '\nPhát triển, vận hành và bảo trì ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nThu thập và sử dụng thông tin của người dùng nhằm mục đích cải thiện chất lượng dịch vụ.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nChặn quyền truy cập đối với những tài khoản vi phạm quy định của ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nThay đổi, bổ sung các điều khoản sử dụng ứng dụng mà không cần thông báo trước.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nNghĩa vụ:', style: Get.textTheme.titleSmall),
                    TextSpan(
                        text:
                            '\nBảo đảm tính an toàn, bảo mật thông tin cho người dùng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nCung cấp dịch vụ hỗ trợ khách hàng chuyên nghiệp, tận tâm.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nGiải quyết khiếu nại của người dùng một cách thỏa đáng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nChính sách hủy đơn hàng:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nPhụ huynh học sinh có thể hủy đơn hàng miễn phí khi đơn hàng ở trạng thái chuẩn bị. Sau thời gian này, phụ huynh học sinh có thể bị tính phí hủy đơn hàng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nNhà cung cấp có thể hủy đơn hàng nếu không thể cung cấp sản phẩm hoặc dịch vụ theo yêu cầu của phụ huynh học sinh.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nChính sách giải quyết tranh chấp:',
                        style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nMọi tranh chấp liên quan đến việc sử dụng ứng dụng sẽ được giải quyết thông qua thương lượng giữa các bên.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nNếu không thể giải quyết tranh chấp qua thương lượng, các bên có thể đưa vụ việc ra tòa án có thẩm quyền để giải quyết.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nLưu ý:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nCác điều khoản sử dụng này có thể thay đổi bất cứ lúc nào mà không cần thông báo trước.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nViệc sử dụng ứng dụng đồng nghĩa với việc phụ huynh học sinh đã đồng ý với tất cả các điều khoản sử dụng được nêu trong tài liệu này.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text: '\nLiên hệ:', style: Get.textTheme.titleMedium),
                    TextSpan(
                        text:
                            '\nNếu có bất kỳ thắc mắc nào về ứng dụng, vui lòng liên hệ với chúng tôi qua beanfast.mail@gmail.com',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nỨng dụng dành cho phụ huynh học sinh có con em theo học tại các trường học đã liên kết với ứng dụng.',
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                        text:
                            '\nCảm ơn quý phụ huynh đã sử dụng ứng dụng của chúng tôi !',
                        style: Get.textTheme.titleSmall),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
