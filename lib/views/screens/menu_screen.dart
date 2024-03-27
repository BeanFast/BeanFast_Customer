import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:beanfast_customer/views/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/menu_controller.dart' as beanfast;
import '/models/menu.dart';

class MenuScreen extends GetView<beanfast.MenuController> {
  const MenuScreen({super.key, required this.schoolId});
  final String schoolId;
  @override
  Widget build(BuildContext context) {
    Get.put(beanfast.MenuController());
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
        ],
      ),
      body: LoadingScreen(
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
                            lastDate:
                                DateTime.now().add(const Duration(days: 7)),
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
                                  side: const BorderSide(
                                      color: Color(0xFF26AA91)),
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
                  child: Row(
                    children: List.generate(
                      7,
                      (index) => GestureDetector(
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
                                    'Combo Burger + nước ngọt số $index',
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
                                      const Expanded(
                                        child: SizedBox(
                                          child: Text(
                                            '150.000đ',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
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
                      ),
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
                    children: List.generate(
                        2,
                        (index) => GestureDetector(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                ),
                                                child: Image.network(
                                                  'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        'Nước ngọt số $index',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '150.000',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Text(
                                                              '150.000đ',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .red),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                  bottomRight:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                              child: Obx(
                                                () => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (controller.amountsSale1[
                                                            index] !=
                                                        0)
                                                      SizedBox(
                                                        width: 40,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .increaseAmountSale1(
                                                                    index);
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_outlined),
                                                        ),
                                                      ),
                                                    if (controller.amountsSale1[
                                                            index] !=
                                                        0)
                                                      Container(
                                                        width: 28,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '${controller.amountsSale1[index]}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .increaseAmountSale1(
                                                                  index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.add_outlined),
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
                            )),
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
                  child: Column(
                    children: List.generate(
                        3,
                        (index) => GestureDetector(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                ),
                                                child: Image.network(
                                                  'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        'Nước ngọt số $index',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const SizedBox(
                                                      child: Text(
                                                        '150.000đ',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.red),
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                  bottomRight:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                              child: Obx(
                                                () => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (controller.amountsCate1[
                                                            index] !=
                                                        0)
                                                      SizedBox(
                                                        width: 40,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .decreaseAmountCate1(
                                                                    index);
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_outlined),
                                                        ),
                                                      ),
                                                    if (controller.amountsCate1[
                                                            index] !=
                                                        0)
                                                      Container(
                                                        width: 28,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '${controller.amountsCate1[index]}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .increaseAmountCate1(
                                                                  index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.add_outlined),
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
                                    // Positioned(
                                    //   top: 4,
                                    //   right: 4,
                                    //   child: Container(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 6, vertical: 3),
                                    //     decoration: const BoxDecoration(
                                    //       color: Colors.red,
                                    //       borderRadius: BorderRadius.only(
                                    //         bottomLeft: Radius.circular(12),
                                    //         topRight: Radius.circular(12),
                                    //       ),
                                    //     ),
                                    //     child: const Text(
                                    //       'SALE',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //         fontSize: 12,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            )),
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
                  child: Column(
                    children: List.generate(
                        3,
                        (index) => GestureDetector(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                ),
                                                child: Image.network(
                                                  'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        'Nước ngọt số $index',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const SizedBox(
                                                      child: Text(
                                                        '150.000đ',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.red),
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                  bottomRight:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                              child: Obx(
                                                () => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (controller.amountsCate1[
                                                            index] !=
                                                        0)
                                                      SizedBox(
                                                        width: 40,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .decreaseAmountCate1(
                                                                    index);
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_outlined),
                                                        ),
                                                      ),
                                                    if (controller.amountsCate1[
                                                            index] !=
                                                        0)
                                                      Container(
                                                        width: 28,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '${controller.amountsCate1[index]}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .increaseAmountCate1(
                                                                  index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.add_outlined),
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
                                  ],
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###", "vi_VN");
      int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
