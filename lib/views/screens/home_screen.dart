import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/contains/theme_color.dart';
import '/controllers/cart_controller.dart';
import '/controllers/home_controller.dart';
import '/controllers/notification_controller.dart';
import '/views/widgets/main_icon_button_widget.dart';
import '/views/widgets/item_profile_widget.dart';
import '/views/widgets/menu_item_widget.dart';
import '/views/widgets/image_default.dart';
import 'data_screen.dart';
import 'deposit_screen.dart';
import 'game_menu_screen.dart';
import 'gift_exchange_screen.dart';
import 'cart_screen.dart';
import 'loading_screen.dart';
import 'notification_screen.dart';
import 'student_form_screen.dart';
import '/utils/constants.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());

    CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        elevation: 0,
        actions: headerActionWidget(),
      ),
      body: LoadingScreen(
        future: controller.fetchData,
        child: RefreshIndicator(
          displacement: 0,
          onRefresh: controller.fetchData,
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Container(
                    height: 40,
                    color: ThemeColor.textButtonColor,
                    child: Obx(
                      () => Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              controller.isMoneyVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 16,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              await controller.toggleMoneyVisibility();
                            },
                          ),
                          Text(
                            controller.moneyValue.value,
                            style: Get.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
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
                            'assets/images/banner_1.jpg',
                            'assets/images/banner_2.png',
                            'assets/images/banner_3.png',
                          ].map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Card(
                                  child: Container(
                                    width: Get.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        //day selecter
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
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
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: controller.backWeek,
                                          icon: const Icon(
                                              Iconsax.arrow_circle_left)),
                                      Obx(
                                        () => TextButton(
                                          child: Text(
                                              '${controller.currentMonth}/${controller.currentYear}',
                                              style: Get.textTheme.titleMedium),
                                          onPressed: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            ).then((value) async {
                                              if (value != null) {
                                                controller
                                                    .updateSelectedDate(value);
                                                controller.now.value = value;
                                                await controller.getSession();
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: controller.nextWeek,
                                          icon: const Icon(
                                              Iconsax.arrow_circle_right)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                      7,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              index + 2 == 8
                                                  ? 'CN'
                                                  : 'T${index + 2}',
                                              style: Get.textTheme.bodySmall,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
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
                                                return;
                                              }
                                              controller.updateSelectedDate(
                                                  chosenDate);
                                              await controller.getSession();
                                            },
                                            child: Obx(
                                              () => Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  color: controller.isSameDay(
                                                          controller
                                                              .selectedDate
                                                              .value,
                                                          controller
                                                              .dayOfWeekDateTime(
                                                                  index)
                                                              .value)
                                                      ? ThemeColor.iconColor
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50), // Make the Container circular
                                                ),
                                                child: Center(
                                                  // Center the Text widget
                                                  child: Text(
                                                    '${controller.dayOfWeek(index)}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: controller.isSameDay(
                                                              controller
                                                                  .selectedDate
                                                                  .value,
                                                              controller
                                                                  .dayOfWeekDateTime(
                                                                      index)
                                                                  .value)
                                                          ? Colors.white
                                                          : controller
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
                                                                      DateTime
                                                                          .now())
                                                              ? Colors.grey
                                                              : Colors.black,
                                                    ),
                                                    textAlign: TextAlign.center,
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
                        ),
                        const SizedBox(height: 20),
                        LoadingScreen(
                          future: controller.getSession,
                          child: Obx(
                            () => DataScreen(
                              hasData: controller.listSession.isNotEmpty,
                              message: 'Chưa có thực đơn',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Sesion Selecter
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (controller.listSession.isNotEmpty)
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text("Khung giờ",
                                              style: Get.textTheme.titleMedium),
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Obx(() => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: controller.listSession
                                                  .map(
                                                    (session) =>
                                                        GestureDetector(
                                                      onTap: () {
                                                        controller
                                                                .selectedSessionId
                                                                .value =
                                                            session.id
                                                                .toString();
                                                        controller.getMenu(
                                                            session.id!);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 5,
                                                                left: 5),
                                                        child: Card(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          color: controller
                                                                      .selectedSessionId
                                                                      .value ==
                                                                  session.id
                                                                      .toString()
                                                              ? ThemeColor
                                                                  .textButtonColor
                                                              : Colors.white,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 5,
                                                                    bottom: 5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    12),
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              DateFormat('HH:mm - ')
                                                                      .format(session
                                                                          .deliveryStartTime!) +
                                                                  DateFormat(
                                                                          'HH:mm')
                                                                      .format(session
                                                                          .deliveryEndTime!),
                                                              style: Get
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                color: controller
                                                                            .selectedSessionId
                                                                            .value ==
                                                                        session
                                                                            .id
                                                                            .toString()
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        //Menu Food
                        Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller.listCategories.isNotEmpty)
                                    Text(
                                      "Loại sản phẩm",
                                      style: Get.textTheme.titleMedium,
                                    ),
                                  //Category List
                                  const SizedBox(height: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: controller.listCategories
                                          .map((category) {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {
                                              //name
                                              controller.selectedCategoryId
                                                  .value = category;
                                              controller
                                                  .sortByCategory(category);
                                            },
                                            child: Card(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              color: controller
                                                          .selectedCategoryId
                                                          .value ==
                                                      category
                                                  ? ThemeColor.textButtonColor
                                                  : Colors.white,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Text(
                                                  category,
                                                  style: Get
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                    color: controller
                                                                .selectedCategoryId
                                                                .value ==
                                                            category
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Obx(
                                      () => MenuItem(
                                          title: 'Combo',
                                          isCombo: true,
                                          sessionId: controller
                                              .selectedSessionId.value,
                                          list: controller.menuModel.value
                                              .listDiscountedCombo),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  // Obx(
                                  //   () => MenuItem(
                                  //       title: 'Combo',
                                  //       isCombo: true,
                                  //       sessionId:
                                  //           controller.selectedSessionId.value,
                                  //       list:
                                  //           controller.menuModel.value.listCombo),
                                  // ),
                                  // const SizedBox(height: 5),
                                  Obx(
                                    () => MenuItem(
                                        isCombo: false,
                                        title: 'Ưu đãi',
                                        sessionId:
                                            controller.selectedSessionId.value,
                                        list: controller.menuModel.value
                                            .listDiscountedFood),
                                  ),
                                  const SizedBox(height: 5),
                                  MenuItem(
                                      isCombo: false,
                                      title: 'Sản phẩm',
                                      sessionId:
                                          controller.selectedSessionId.value,
                                      list:
                                          controller.menuModel.value.listFood),
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
            ],
          ),
        ),
      ),
    );
  }
}

void showProfilesDialog(Function() onPressed) {
  HomeController controller = Get.find();
  Get.dialog(AlertDialog(
    title: const Text('Chọn học sinh'),
    content: SizedBox(
      width: Get.width,
      child: SizedBox(
        child: LoadingScreen(
          future: controller.getProfiles,
          child: Obx(() => DataScreen(
                hasData: controller.listProfile.isNotEmpty,
                message: 'Chưa có học sinh',
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.listProfile.map((profile) {
                      return ItemProfile(
                        model: profile,
                        onPressed: () => {
                          currentProfile.value = profile,
                          Get.back(),
                          onPressed(),
                        },
                      );
                    }).toList(),
                  ),
                ),
              )),
        ),
      ),
    ),
  ));
}

List<Widget> headerActionWidget() {
  HomeController controller = Get.find();
  CartController cartController = Get.put(CartController());

  return <Widget>[
    SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => currentProfile.value != null
                    ? GestureDetector(
                        onTap: () {
                          showProfilesDialog(() async {
                            //get profile
                            if (currentProfile.value != null) {
                              await controller.getSession();
                            }
                            //get session of profile
                            if (controller.listSession.isNotEmpty) {
                              controller.selectedSessionId.value =
                                  controller.listSession[0].id!;
                              controller
                                  .getMenu(controller.selectedSessionId.value);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            width: Get.width - 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black54,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CustomNetworkImage(
                                      currentProfile.value!.avatarPath
                                          .toString(),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentProfile.value!.fullName
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        currentProfile.value!.school!.name
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: currentProfile.value!.school !=
                                                null
                                            ? Get.textTheme.bodySmall!.copyWith(
                                                color: Colors.black54,
                                              )
                                            : Get.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Get.to(() => const StudentFormScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 3, bottom: 3),
                            width: Get.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black54,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Iconsax.add,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Thêm học sinh',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Chưa có thông tin',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: Colors.black,
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
                    width: 50,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: const Icon(Iconsax.notification, size: 24),
                        onPressed: () {
                          Get.to(() => const NotificationScreen());
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible:
                          !Get.find<NotificationController>().allDone.value,
                      child: Positioned(
                        top: 15,
                        right: 12,
                        width: 10,
                        height: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: const Icon(Iconsax.shopping_cart, size: 24),
                        onPressed: () {
                          Get.to(() => const CartScreen());
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: cartController.itemCount.value != 0,
                      child: Positioned(
                        top: 5,
                        right: 3,
                        width: 18,
                        height: 18,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              cartController.itemCount.value.toString(),
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
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainIconButton(
                    icon: Iconsax.wallet_add,
                    text: "Nạp tiền",
                    isNew: false,
                    onPressed: () {
                      Get.to(() => const DepositeScreen());
                    },
                  ),
                  MainIconButton(
                    icon: Iconsax.gift,
                    text: "Đổi thưởng",
                    isNew: true,
                    onPressed: () {
                      Get.to(() => const ExchangeGiftScreen());
                    },
                  ),
                  MainIconButton(
                    icon: Iconsax.game,
                    text: "Trò chơi",
                    isNew: true,
                    onPressed: () {
                      Get.to(() => const GameMenuScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  ];
}
