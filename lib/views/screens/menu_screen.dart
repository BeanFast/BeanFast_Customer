import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/contrains/theme_color.dart';
import '/controllers/menu_controller.dart' as beanfast;
import '/utils/formater.dart';
import '/views/screens/loading_screen.dart';
import '/views/screens/product_detail_screen.dart';
import 'home_screen.dart';

class MenuScreen extends GetView<beanfast.MenuController> {
  const MenuScreen({super.key, required this.schoolId});
  final String schoolId;

  @override
  Widget build(BuildContext context) {
    Get.put(beanfast.MenuController());
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
    return Scaffold(
      appBar: AppBar(
        actions: headerActionWidget(),
      ),
      body: Obx(() {
        return controller.isValidate.value
            ? loadingScreen(context)
            : const SizedBox();
      }),
    );
  }

  LoadingScreen loadingScreen(BuildContext context) {
    return LoadingScreen(
      future: () async {
        controller.getData(schoolId);
      },
      child: SingleChildScrollView(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                child: Row(
                  children: List.generate(
                    10,
                    (index) => Obx(
                      () => Container(
                        alignment: Alignment.center,
                        height: 40,
                        margin: const EdgeInsets.only(right: 15),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              controller.selectedIndex.value == index
                                  ? Colors.white
                                  : HexColor("#26AA91"),
                            ), // Text color
                            backgroundColor: MaterialStateProperty.all<Color>(
                              controller.selectedIndex.value == index
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
                            controller.selectedIndex.value = index;
                            // Get.snackbar('Click category', index.toString());
                          },
                          child: Text(
                            'Bánh mì $index',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //FoodCombo List
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: controller.listCombos.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(const ProductDetailScreen());
                        },
                        child: Card(
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    e.food!.name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          child: Text(
                                            Formater.formatMoney(
                                                e.price.toString()),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon:
                                                const Icon(Icons.add_outlined)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Giảm giá",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Food On Sale list
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: controller.listFoods.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(const ProductDetailScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Stack(
                          children: [
                            Card(
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          e.food!.imagePath.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                e.food!.name.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Formater.formatMoney(
                                                      e.food!.price.toString()),
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: SizedBox(
                                                    child: Text(
                                                      Formater.formatMoney(
                                                          e.price.toString()),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.red),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // if (controller
                                          //         .amountsSale1[index] !=
                                          //     0)
                                          //   SizedBox(
                                          //     width: 40,
                                          //     child: IconButton(
                                          //       onPressed: () {
                                          //         controller
                                          //             .increaseAmountSale1(
                                          //                 index);
                                          //       },
                                          //       icon: const Icon(
                                          //           Icons.remove_outlined),
                                          //     ),
                                          //   ),
                                          // if (controller
                                          //         .amountsSale1[index] !=
                                          //     0)
                                          //   Container(
                                          //     width: 28,
                                          //     alignment: Alignment.center,
                                          //     child: Text(
                                          //       '${controller.amountsSale1[index]}',
                                          //       style: const TextStyle(
                                          //           fontSize: 16),
                                          //     ),
                                          //   ),
                                          // SizedBox(
                                          //   width: 40,
                                          //   child: IconButton(
                                          //     onPressed: () {
                                          //       controller
                                          //           .increaseAmountSale1(
                                          //               index);
                                          //     },
                                          //     icon: const Icon(
                                          //         Icons.add_outlined),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'SALE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Nước uống",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Food list
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => Column(
                    children: controller.listFoods.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(const ProductDetailScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Stack(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                          child: Image.network(
                                            e.food!.imagePath.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  e.food!.name.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                child: Text(
                                                  Formater.formatMoney(
                                                      e.price.toString()),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 110,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // if (controller
                                            //         .amountsCate1[index] !=
                                            //     0)
                                            //   SizedBox(
                                            //     width: 40,
                                            //     child: IconButton(
                                            //       onPressed: () {
                                            //         controller
                                            //             .decreaseAmountCate1(
                                            //                 index);
                                            //       },
                                            //       icon: const Icon(
                                            //           Icons.remove_outlined),
                                            //     ),
                                            //   ),
                                            // if (controller
                                            //         .amountsCate1[index] !=
                                            //     0)
                                            //   Container(
                                            //     width: 28,
                                            //     alignment: Alignment.center,
                                            //     child: Text(
                                            //       '${controller.amountsCate1[index]}',
                                            //       style: const TextStyle(
                                            //           fontSize: 16),
                                            //     ),
                                            //   ),
                                            // SizedBox(
                                            //   width: 40,
                                            //   child: IconButton(
                                            //     onPressed: () {
                                            //       controller
                                            //           .increaseAmountCate1(
                                            //               index);
                                            //     },
                                            //     icon: const Icon(
                                            //         Icons.add_outlined),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                children: List.generate(
                  controller.sessions.length,
                  (index) => ListTile(
                    title: Text(controller.sessions[index]),
                    onTap: () {
                      Navigator.of(context).pop(controller.sessions[index]);
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

// class CurrencyInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.text.isEmpty) {
//       return newValue.copyWith(text: '');
//     } else if (newValue.text.compareTo(oldValue.text) != 0) {
//       int selectionIndexFromTheRight =
//           newValue.text.length - newValue.selection.end;
//       final f = NumberFormat("#,###", "vi_VN");
//       int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
//       final newString = f.format(num);
//       return TextEditingValue(
//         text: newString,
//         selection: TextSelection.collapsed(
//             offset: newString.length - selectionIndexFromTheRight),
//       );
//     } else {
//       return newValue;
//     }
//   }
// }
