import 'package:beanfast_customer/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../contrains/theme_color.dart';
import '/controllers/auth_controller.dart';
import '/controllers/cart_controller.dart';
import '/controllers/home_controller.dart';
import '/views/widgets/item_profile_widget.dart';
import 'cart_screen.dart';
import 'loading_screen.dart';
import 'notification_screen.dart';
import 'student_form_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    var authController = Get.find<AuthController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,

          // toolbarHeight: 90,

          actions: headerActionWidget(),
        ),
        body: Stack(
          children: [
            Lottie.asset(
              'assets/images/background_home.json',
              width: Get.width,
              repeat: false,
              animate: false,
              height: 240,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 150,
                        autoPlayInterval: const Duration(seconds: 15),
                      ),
                      items: [
                        // Replace these with your image widgets
                        'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg',
                        'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg',
                        'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg',
                      ].map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                // Handle the tap
                                Get.snackbar(
                                  "SnakeBar Title",
                                  'Image clicked: $imageUrl',
                                  snackPosition: SnackPosition.TOP,
                                );
                              },
                              child: Card(
                                color: Colors.red,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    //day selecter
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeColor.itemColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width - 25,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: controller.backWeek,
                                    icon:
                                        const Icon(Iconsax.arrow_circle_left)),
                                Obx(
                                  () => TextButton(
                                    child: Text(
                                        '${controller.currentMonth}/${controller.currentYear}',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black)),
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                      ).then((value) {
                                        if (value != null) {
                                          controller.updateSelectedDate(value);
                                          controller.now.value = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: controller.nextWeek,
                                    icon:
                                        const Icon(Iconsax.arrow_circle_right)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                7,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        index + 2 == 8 ? 'CN' : 'T${index + 2}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DateTime chosenDate = controller
                                            .dayOfWeekDateTime(index)
                                            .value;
                                        DateTime today = DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day);
                                        if (chosenDate.isBefore(today) &&
                                            !controller.isSameDay(
                                                chosenDate, today)) {
                                          // If the chosen date is in the past and not today, return early without updating the selected date
                                          return;
                                        }
                                        controller
                                            .updateSelectedDate(chosenDate);
                                        print('Chosen date: $chosenDate');
                                      },
                                      child: Obx(
                                        () => Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: controller.isSameDay(
                                                    controller
                                                        .selectedDate.value,
                                                    controller
                                                        .dayOfWeekDateTime(
                                                            index)
                                                        .value)
                                                ? Colors.blue
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                                50), // Make the Container circular
                                          ),
                                          child: Obx(
                                            () => Center(
                                              // Center the Text widget
                                              child: Text(
                                                '${controller.dayOfWeek(index)}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: controller
                                                              .dayOfWeekDateTime(
                                                                  index)
                                                              .value
                                                              .isBefore(
                                                                DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day,
                                                                ),
                                                              ) &&
                                                          !controller.isSameDay(
                                                              controller
                                                                  .dayOfWeekDateTime(
                                                                      index)
                                                                  .value,
                                                              DateTime.now())
                                                      ? Colors.grey
                                                      : Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Sesion Selecter
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          3,
                          (index) => Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.selectedSession.value = index;
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Card(
                                  color:
                                      controller.selectedSession.value == index
                                          ? Colors.blue
                                          : Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text('Sáng ${index + 1}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Menu Food
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showProfilesDialog(
      BuildContext context, final void Function() onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingScreen(
            future: controller.getProfiles,
            child: AlertDialog(
              title: const Text('Chọn học sinh'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4 + 80,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        child: Obx(() => Column(
                              children: controller.listProfile.map((e) {
                                return ItemProfile(
                                  model: e,
                                  onPressed: () =>
                                      {currentProfile.value = e, onPressed()},
                                );
                              }).toList(),
                            )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(10.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.to(const StudentFormScreen(isUpdate: false));
                        },
                        child: const Text('Thêm người mới',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

List<Widget> headerActionWidget() {
  Get.put(CartController());
  return <Widget>[
    GestureDetector(
      onTap: () {
        Get.snackbar('title', 'message');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: Get.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: Image.network(
                          'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg')
                      .image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyen van a',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Fast food delivery',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    ),
    const Spacer(),
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 50,
          height: 50,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Iconsax.notification, size: 30),
              onPressed: () {
                Get.to(const NotificationScreen());
              },
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Positioned(
            top: 5,
            right: 3,
            width: 20,
            height: 20,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    '99+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
        ),
      ],
    ),
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 50,
          height: 50,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Iconsax.shopping_cart, size: 30),
              onPressed: () {
                Get.to(const CartScreen());
              },
            ),
          ),
        ),
        // if (Get.find<CartController>().itemCount.value != 0)
        Obx(
          () => Visibility(
            visible: Get.find<CartController>().itemCount.value != 0,
            child: Positioned(
              top: 5,
              right: 3,
              width: 20,
              height: 20,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    Get.find<CartController>().itemCount.value.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ];
}
          // Padding(
                    //   padding: const EdgeInsets.only(top: 20, bottom: 10),
                    //   child: Card(
                    //     color: Colors.grey[300],
                    //     child: Column(
                    //       children: [
                    //         Container(
                    //           decoration: BoxDecoration(
                    //             color: ThemeColor.itemColor,
                    //             borderRadius: const BorderRadius.all(
                    //               Radius.circular(12),
                    //             ),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               MainIconButton(
                    //                 icon: Iconsax.shop_add,
                    //                 text: "Đặt hàng",
                    //                 isNew: false,
                    //                 onPressed: () {
                    //                   showProfilesDialog(context, () {
                    //                     // currentUser.value
                    //                     Get.back();
                    //                     Get.to(const SessionScreen());
                    //                   });
                    //                 },
                    //               ),
                    //               MainIconButton(
                    //                 icon: Iconsax.wallet_add,
                    //                 text: "Nạp tiền",
                    //                 // text: "Nạp tiền",
                    //                 isNew: false,
                    //                 onPressed: () {
                    //                   // Get.to(const MyLoadingWidget());
                    //                   Get.to(DepositeScreen());
                    //                 },
                    //               ),
                    //               MainIconButton(
                    //                 icon: Iconsax.gift,
                    //                 text: "Đổi thưởng",
                    //                 isNew: true,
                    //                 onPressed: () {
                    //                   showProfilesDialog(context, () {
                    //                     Get.back();
                    //                     Get.to(const GiftExchangeScreen());
                    //                   });
                    //                 },
                    //               ),
                    //               MainIconButton(
                    //                 icon: Iconsax.game,
                    //                 text: "Trò chơi",
                    //                 isNew: true,
                    //                 onPressed: () {
                    //                   showProfilesDialog(context, () {
                    //                     Get.back();
                    //                     Get.to(const GameSelectScreen());
                    //                   });
                    //                   // Get.to(QRScanScreen());
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: 40,
                    //           child: Obx(
                    //             () => Row(
                    //               children: [
                    //                 IconButton(
                    //                   icon: Icon(
                    //                     authController.isMoneyVisible.value
                    //                         ? Icons.visibility_outlined
                    //                         : Icons.visibility_off_outlined,
                    //                     size: 16,
                    //                   ),
                    //                   onPressed: () {
                    //                     authController.toggleMoneyVisibility();
                    //                   },
                    //                 ),
                    //                 Text(
                    //                   authController.moneyValue.value,
                    //                   style: const TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.bold),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
         
           