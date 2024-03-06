import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class DepositeScreen extends StatelessWidget {
  final DepositeController depositeController = Get.put(DepositeController());
  DepositeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nạp tiền',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Số tiền nạp (đ)', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 64,
                  width: 110,
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
                    onPressed: () {
                      depositeController.updateMoney('100.000');
                    },
                    child:
                        const Text('110.000', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 110,
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
                    onPressed: () {
                      depositeController.updateMoney('200.000');
                    },
                    child:
                        const Text('200.000', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 110,
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
                    onPressed: () {
                      depositeController.updateMoney('300.000');
                    },
                    child:
                        const Text('300.000', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 64,
                  width: 110,
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
                    onPressed: () {
                      depositeController.updateMoney('500.000');
                    },
                    child:
                        const Text('500.000', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 110,
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
                    onPressed: () {
                      depositeController.updateMoney('1.000.000');
                    },
                    child:
                        const Text('1.000.000', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 110,
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
                    onPressed: () {
                      depositeController.updateMoney('2.000.000');
                    },
                    child:
                        const Text('2.000.000', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width, // Set the width
              height: 85,
              child: TextFormField(
                controller: depositeController.textController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                maxLength: 15,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Giá trị',
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giá trị';
                  }
                  final number = num.tryParse(value);
                  if (number == null) {
                    return 'Vui lòng nhập đúng giá trị';
                  }
                  if (number <= 0) {
                    return 'Vui lòng nhập đúng giá trị';
                  }
                  return null;
                },
                onChanged: (value) => depositeController.updateMoney(value),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Phương thức thanh toán', style: TextStyle(fontSize: 16)),
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
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Nạp tiền:', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          Obx(() => Text(depositeController.money.value)),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Tổng thanh toán:', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          Obx(() => Text(depositeController.money.value)),
                        ],
                      ),
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

class DepositeController extends GetxController {
  final textController = TextEditingController();
  RxString money = ''.obs;

  void updateMoney(String value) {
    textController.text = value;
    money.value = value.isEmpty ? ' đ' : '$value đ';
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
