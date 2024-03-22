import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/views/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuScreen extends StatelessWidget {
  final MenuController menuController = Get.put(MenuController());
  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null &&
                            picked != menuController.selectedDate.value) {
                          menuController.updateDate(picked);
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            "Ngày: ${DateFormat('dd/MM/yyyy').format(menuController.selectedDate.value)}",
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Category List
              const SizedBox(height: 10),
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
                              menuController.selectedIndex.value == index
                                  ? Colors.white
                                  : HexColor("#26AA91"),
                            ), // Text color
                            backgroundColor: MaterialStateProperty.all<Color>(
                              menuController.selectedIndex.value == index
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
                            menuController.selectedIndex.value = index;
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
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                fit: BoxFit.cover,
                                width: 150,
                                height: 100,
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 140,
                                child: Text(
                                  'Combo Burger + nước ngọt số $index',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 100,
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
                                    SizedBox(
                                      width: 40,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add_outlined)),
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
              const SizedBox(height: 15),
              const Text(
                "Giảm giá",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Food On Sale list
              const SizedBox(height: 10),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          right: 10,
                                          left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: Image.network(
                                                  'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                height: 100,
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              216,
                                                      child: Text(
                                                        'Nước ngọt số $index',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              216,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            '150.000',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.red),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          SizedBox(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    216) /
                                                                2,
                                                            child: const Text(
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
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.add_outlined),
                                              iconSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(Icons.local_offer,
                                        color: Colors.red), // Sale icon
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
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        'https://domf5oio6qrcr.cloudfront.net/medialibrary/8371/bigstock-Hamburger-And-French-Fries-263887.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                216,
                                            child: Text(
                                              'Nước ngọt số $index',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                216,
                                            child: const Text(
                                              '150.000đ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_outlined),
                                    iconSize: 20,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  RxInt selectedIndex = 0.obs;
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
