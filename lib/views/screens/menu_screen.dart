import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          HexColor("#26AA91")), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    child: Text(
                      "Ngày: ${DateFormat('dd-MM-yyyy').format(menuController.selectedDate.value)}",
                    ),
                  ),
                ),
              );
            }),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    HexColor("#26AA91")), // Text color
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(16.0)),
                shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFF26AA91)),
                  ),
                ),
              ),
              onPressed: () async {},
              child: const Text(
                "Bánh mì",
              ),
            ),
            
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                // autoPlayInterval: Duration(seconds: 15),
                height: 206,
                viewportFraction: 0.45,
              ),
              items: [
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvzilsrox1351bECnEzpdGsKYjKdEDN7fSAQ&usqp=CAU',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvzilsrox1351bECnEzpdGsKYjKdEDN7fSAQ&usqp=CAU',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvzilsrox1351bECnEzpdGsKYjKdEDN7fSAQ&usqp=CAU',
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
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 150,
                              ),
                              const SizedBox(height: 5),
                              const SizedBox(
                                width: 130,
                                child: Text(
                                  'Combo Burger + nước ngọt',
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
                                        '15.000.000 VNĐ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.add_shopping_cart)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Phương thức thanh toán',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network(
                          'https://vnpay.vn/s1/statics.vnpay.vn/2023/9/06ncktiwd6dc1694418196384.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 64,
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green), // Background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text('Nạp tiền', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
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
