import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/views/screens/deposit_screen.dart';
import 'package:beanfast_customer/views/screens/game_select_screen.dart';
import 'package:beanfast_customer/views/screens/gift_exchange_screen.dart';
import 'package:beanfast_customer/views/widgets/main_icon_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '/contrains/theme_color.dart';
import '/controllers/cart_controller.dart';
import '/controllers/home_controller.dart';
import '/utils/constants.dart';
import '/views/widgets/item_profile_widget.dart';
import '/views/widgets/menu_item_widget.dart';
import 'cart_screen.dart';
import 'loading_screen.dart';
import 'notification_screen.dart';
import 'product_detail_screen.dart';
import 'student_form_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: headerActionWidget(),
      ),
      body: RefreshIndicator(
        displacement: 0,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            // controller.getSession(
            //     currentProfile.value.school!.id!, controller.now.value);
          });
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Lottie.asset(
                'assets/images/background_home.json',
                width: Get.width,
                repeat: false,
                animate: false,
                height: 220,
                fit: BoxFit.cover,
              ),
              Padding(
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
                                child: Container(
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
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
                    Card(
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeColor.itemColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainIconButton(
                                  icon: Iconsax.wallet_add,
                                  text: "Nạp tiền",
                                  // text: "Nạp tiền",
                                  isNew: false,
                                  onPressed: () {
                                    // Get.to(const MyLoadingWidget());
                                    Get.to(DepositeScreen());
                                  },
                                ),
                                MainIconButton(
                                  icon: Iconsax.gift,
                                  text: "Đổi thưởng",
                                  isNew: true,
                                  onPressed: () {
                                    showProfilesDialog(() {
                                      Get.back();
                                      Get.to(ExchangeGiftScreen());
                                    });
                                  },
                                ),
                                MainIconButton(
                                  icon: Iconsax.game,
                                  text: "Trò chơi",
                                  isNew: true,
                                  onPressed: () {
                                    showProfilesDialog(() {
                                       Get.back();
                                      Get.to(const GameSelectScreen());
                                     
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Obx(
                              () => Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      authController.isMoneyVisible.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      authController.toggleMoneyVisibility();
                                    },
                                  ),
                                  Text(
                                    authController.moneyValue.value,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                                        controller.getSession(
                                            currentProfile.value.school!.id!,
                                            chosenDate);
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
                                                ? Colors.green
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
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: Card(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        color: controller
                                                    .selectedSessionId.value ==
                                                session.id.toString()
                                            ? Colors.green
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
                                            DateFormat('HH:mm - ').format(
                                                    session
                                                        .deliveryStartTime!) +
                                                DateFormat('HH:mm').format(
                                                    session.deliveryEndTime!),
                                            style: Get.textTheme.bodySmall!
                                                .copyWith(
                                              color: controller
                                                          .selectedSessionId
                                                          .value ==
                                                      session.id.toString()
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
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
                              Text(
                                "Loại sản phẩm",
                                style: Get.textTheme.titleMedium,
                              ),
                              //Category List
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Obx(() => Row(
                                      children: controller.menuModel.value
                                          .listCategories.entries
                                          .map((e) {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.selectedCategoryId
                                                  .value = e.value;
                                            },
                                            child: Card(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              color: controller
                                                          .selectedCategoryId
                                                          .value ==
                                                      e.value
                                                  ? Colors.green
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
                                                  e.value,
                                                  style: Get
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                    color: controller
                                                                .selectedCategoryId
                                                                .value ==
                                                            e.value
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ),
                              const SizedBox(height: 5),
                              Obx(
                                () => MenuItem(
                                    title: 'Combo',
                                    isCombo: true,
                                    onTap: () {
                                      Get.to(const ProductDetailScreen());
                                    },
                                    sessionId:
                                        controller.selectedSessionId.value,
                                    list: controller.menuModel.value.listCombo),
                              ),
                              const SizedBox(height: 5),
                              Obx(
                                () => MenuItem(
                                    isCombo: false,
                                    title: 'Ưu đãi',
                                    onTap: () {
                                      Get.to(const ProductDetailScreen());
                                    },
                                    sessionId:
                                        controller.selectedSessionId.value,
                                    list: controller
                                        .menuModel.value.listDiscountedFood),
                              ),
                              const SizedBox(height: 5),
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
            ],
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
    content: LoadingScreen(
      future: controller.getProfiles,
      child: SizedBox(
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
                child: const Text('Thêm người mới',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}

List<Widget> headerActionWidget() {
  Get.put(CartController());
  return <Widget>[
    GestureDetector(
      onTap: () {
        showProfilesDialog(() {
          Get.back();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          color: Colors.transparent,
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
