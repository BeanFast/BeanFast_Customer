import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/contrains/theme_color.dart';
import '/views/widgets/menu_item_widget.dart';
import '/controllers/cart_controller.dart';
import '/controllers/home_controller.dart';
import '/views/widgets/item_profile_widget.dart';
import 'cart_screen.dart';
import 'loading_screen.dart';
import 'notification_screen.dart';
import 'product_detail_screen.dart';
import 'student_form_screen.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 90,
          actions: headerActionWidget(),
        ),
        body: SafeArea(
          child: Padding(
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
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
                                  icon: const Icon(Iconsax.arrow_circle_left)),
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
                                  icon: const Icon(Iconsax.arrow_circle_right)),
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
                                      style: const TextStyle(fontSize: 14),
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
                                      controller.updateSelectedDate(chosenDate);
                                      controller.getSession(
                                          currentProfile.value.school!.id!,
                                          chosenDate);
                                      logger.i('Chosen date: $chosenDate');
                                    },
                                    child: Obx(
                                      () => Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: controller.isSameDay(
                                                  controller.selectedDate.value,
                                                  controller
                                                      .dayOfWeekDateTime(index)
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
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.listSession
                            .map(
                              (session) => Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.selectedSessionId.value =
                                        session.id.toString();
                                    controller.getMenu(session.id!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Card(
                                      color:
                                          controller.selectedSessionId.value ==
                                                  session.id.toString()
                                              ? Colors.blue
                                              : Colors.white,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                            DateFormat('HH:mm - ').format(
                                                    session
                                                        .deliveryStartTime!) +
                                                DateFormat('HH:mm').format(
                                                    session.deliveryEndTime!),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  //Menu Food
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Loại sản phẩm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //Category List
                            const SizedBox(height: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Obx(() => Row(
                                    children: controller
                                        .menuModel.value.listCategories.entries
                                        .map((e) {
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: TextButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              controller.selectedCategoryId
                                                          .value ==
                                                      e.value
                                                  ? Colors.white
                                                  : HexColor("#26AA91"),
                                            ), // Text color
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              controller.selectedCategoryId
                                                          .value ==
                                                      e.value
                                                  ? HexColor("#26AA91")
                                                  : Colors.white,
                                            ), // Background color
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(10),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    color: Color(0xFF26AA91)),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            controller.selectedCategoryId
                                                .value = e.value;
                                            // Get.snackbar('Click category', index.toString());
                                          },
                                          child: Text(
                                            e.value,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => MenuItem(
                                  title: 'Combo',
                                  isCombo: true,
                                  onTap: () {
                                    Get.to(const ProductDetailScreen());
                                  },
                                  sessionId: controller.selectedSessionId.value,
                                  list: controller.menuModel.value.listCombo),
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () => MenuItem(
                                  isCombo: false,
                                  title: 'Ưu đãi',
                                  onTap: () {
                                    Get.to(const ProductDetailScreen());
                                  },
                                  sessionId: controller.selectedSessionId.value,
                                  list: controller
                                      .menuModel.value.listDiscountedFood),
                            ),
                            MenuItem(
                                isCombo: false,
                                title: 'Sản phẩm',
                                onTap: () {
                                  Get.to(const ProductDetailScreen());
                                },
                                sessionId: controller.selectedSessionId.value,
                                list: controller.menuModel.value.listFood),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showProfilesDialog(Function() onPressed) {
  HomeController controller = Get.find<HomeController>();
  Get.dialog(AlertDialog(
    title: const Text('Chọn học sinh'),
    content: SizedBox(
      width: Get.width,
      height: Get.height * 0.4 + 80,
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height * 0.4,
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
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              onPressed: () {
                Get.to(const StudentFormScreen(isUpdate: false));
              },
              child:
                  const Text('Thêm người mới', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    ),
  ));
}

List<Widget> headerActionWidget() {
  Get.put(CartController());

  return <Widget>[
    GestureDetector(
      onTap: () {
        showProfilesDialog(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: Get.width * 0.5,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: Image.network(
                            currentProfile.value.avatarPath.toString())
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
                        currentProfile.value.fullName.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        currentProfile.value.school!.name.toString(),
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
