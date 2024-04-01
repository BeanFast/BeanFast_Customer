import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/contrains/theme_color.dart';
import '/controllers/menu_controller.dart' as beanfast;
import '/views/screens/loading_screen.dart';
import '/views/screens/product_detail_screen.dart';
import '/views/widgets/menu_item_widget.dart';
import 'home_screen.dart';

class SessionScreen extends GetView<beanfast.MenuController> {
  const SessionScreen({super.key, required this.schoolId});
  final String schoolId;

  @override
  Widget build(BuildContext context) {
    Get.put(beanfast.MenuController());
    return Scaffold(
        appBar: AppBar(
          actions: headerActionWidget(),
        ),
        body: LoadingScreen(
          future: () async {
            controller.getData(schoolId);
          },
          child: Obx(() {
            return controller.isValidate.value
                ? const MenuScreen()
                : menuDetailScreen(context);
          }),
        ));
  }

  Widget menuDetailScreen(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final DateTime? picked = await showDatePicker(
        locale: const Locale("vi", "VI"),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)),
      );
      if (picked != null && picked != controller.selectedDate.value) {
        final session = await secsionPicker(context);
        if (session != null) {
          controller.updateDate(picked);
        } else {
          Get.back();
        }
      } else {
        Get.back();
      }
    });
    return Container(
      color: Colors.blue,
    );
  }

  Future<String?> secsionPicker(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text('Chọn thời điểm giao'),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          content: SizedBox(
            height: Get.height * 0.3,
            width: Get.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children:
                    // controller.model.
                    List.generate(
                  controller.listSession.length,
                  (index) => ListTile(
                    title: Text(DateFormat('dd/MM/yyyy')
                        .format(controller.listSession[index].orderStartTime!)),
                    onTap: () {
                      Navigator.of(context).pop(controller
                          .listSession[index].orderStartTime
                          .toString());
                      controller.isValidate.value = true;
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    if (result != null) {
      return result;
    } else {
      Get.back();
      return null;
    }
  }
}

class MenuScreen extends GetView<beanfast.MenuController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Obx(() {
              return Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 40,
                  width: 170,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          HexColor("#26AA91")), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xFF26AA91)),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        locale: const Locale("vi", "VI"),
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 7)),
                      );
                      if (picked != null &&
                          picked != controller.selectedDate.value) {
                        controller.updateDate(picked);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          "Ngày: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}",
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
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
                    children: controller.menuModel.value.listCategories.entries
                        .map((e) {
                      return Container(
                        alignment: Alignment.center,
                        height: 40,
                        margin: const EdgeInsets.only(right: 15),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              controller.selectedCategoryId.value == e.value
                                  ? Colors.white
                                  : HexColor("#26AA91"),
                            ), // Text color
                            backgroundColor: MaterialStateProperty.all<Color>(
                              controller.selectedCategoryId.value == e.value
                                  ? HexColor("#26AA91")
                                  : Colors.white,
                            ), // Background color
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(10),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    const BorderSide(color: Color(0xFF26AA91)),
                              ),
                            ),
                          ),
                          onPressed: () {
                            controller.selectedCategoryId.value = e.value;
                            // Get.snackbar('Click category', index.toString());
                          },
                          child: Text(
                            e.value,
                            style: const TextStyle(fontSize: 14),
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
                  list: controller.menuModel.value.listDiscountedFood),
            ),
            Obx(
              () => MenuItem(
                  isCombo: false,
                  title: 'Sản phẩm',
                  onTap: () {
                    Get.to(const ProductDetailScreen());
                  },
                  list: controller.menuModel.value.listFood),
            ),
          ],
        ),
      ),
    );
  }
}
