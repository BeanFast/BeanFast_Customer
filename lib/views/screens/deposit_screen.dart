import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/services/transaction_service.dart';
import 'package:beanfast_customer/views/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../enums/menu_index_enum.dart';
import '../../utils/constants.dart';
import 'splash_screen.dart';

class DepositeScreen extends StatelessWidget {
  final DepositeController depositeController = Get.put(DepositeController());
  DepositeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Nạp tiền',
      )),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số tiền nạp (đ)', style: Get.textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 55,
                            width: Get.width / 3.5,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(ThemeColor
                                        .itemColor), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ThemeColor.textButtonColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                depositeController.updateMoney('100.000');
                              },
                              child: Text(
                                '100.000',
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: ThemeColor.textButtonColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: Get.width / 3.5,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(ThemeColor
                                        .itemColor), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ThemeColor.textButtonColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                depositeController.updateMoney('200.000');
                              },
                              child: Text(
                                '200.000',
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: ThemeColor.textButtonColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: Get.width / 3.5,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(ThemeColor
                                        .itemColor), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ThemeColor.textButtonColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                depositeController.updateMoney('300.000');
                              },
                              child: Text(
                                '300.000',
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: ThemeColor.textButtonColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 55,
                            width: Get.width / 3.5,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(ThemeColor
                                        .itemColor), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ThemeColor.textButtonColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                depositeController.updateMoney('500.000');
                              },
                              child: Text(
                                '500.000',
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: ThemeColor.textButtonColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: Get.width / 3.5,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(ThemeColor
                                        .itemColor), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ThemeColor.textButtonColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                depositeController.updateMoney('1.000.000');
                              },
                              child: Text(
                                '1.000.000',
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: ThemeColor.textButtonColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: Get.width / 3.5,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(ThemeColor
                                        .itemColor), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ThemeColor.textButtonColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                depositeController.updateMoney('2.000.000');
                              },
                              child: Text(
                                '2.000.000',
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: ThemeColor.textButtonColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: TextFormField(
                          controller: depositeController.textController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter(),
                          ],
                          maxLength: 13,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            labelText: 'Giá trị',
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập giá trị';
                            }
                            final number =
                                num.tryParse(value.replaceAll('.', ''));

                                print(number);

                            if (number == null) {
                              return 'Vui lòng nhập đúng giá trị';
                            }

                            if (number < 10000) {
                              return 'Giá trị phải lớn hơn 10.000đ';
                            }
                            if (number > 50000000) {
                              return 'Giá trị không được vượt quá 50.000.000đ';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Phương thức thanh toán',
                        style: Get.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: ThemeColor.textButtonColor,
                          border: Border.all(
                            color: ThemeColor.textButtonColor,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            'https://vnpay.vn/s1/statics.vnpay.vn/2023/9/06ncktiwd6dc1694418196384.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Nạp tiền:',
                                        style: Get.textTheme.bodyLarge),
                                    const Spacer(),
                                    Obx(
                                      () => Text(depositeController.money.value,
                                          style: Get.textTheme.bodyLarge),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Tổng thanh toán:',
                                        style: Get.textTheme.bodyLarge),
                                    const Spacer(),
                                    Obx(
                                      () => Text(depositeController.money.value,
                                          style: Get.textTheme.bodyLarge),
                                    ),
                                  ],
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
              GradientButton(
                text: 'Nạp tiền',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var url = await TransactionService()
                        .createVnpayRequest(depositeController.moneyInt);

                    Get.to(
                      // ignore: deprecated_member_use
                      () => WillPopScope(
                        onWillPop: () async {
                          return await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Xác nhận'),
                                  content:
                                      const Text('Bạn có muốn thoát không?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Không'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text('Có'),
                                    ),
                                  ],
                                ),
                              ) ??
                              false;
                        },
                        child: SafeArea(
                          child: Scaffold(
                            body: WebView(
                              initialUrl: url,
                              javascriptMode: JavascriptMode.unrestricted,
                              javascriptChannels: {
                                JavascriptChannel(
                                  name: 'Pay',
                                  onMessageReceived:
                                      (JavascriptMessage message) async {
                                    var resultMessage = message.message;
                                    if (resultMessage == 'true') {
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      // currentUser.value =
                                      //     await AuthService().getUser();
                                      changePage(MenuIndexState.home.index);
                                      Get.offAll(const SplashScreen());
                                    } else {
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      Get.back();
                                    }
                                  },
                                ),
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DepositeController extends GetxController {
  final textController = TextEditingController();

  int moneyInt = 0;
  RxString money = ''.obs;
  void updateMoney(String value) {
    if (value.isNotEmpty) {
      textController.text = value;
      moneyInt = int.parse(value.replaceAll(".", ""));
    } else {
      moneyInt = 0;
    }
    money.value = value.isEmpty ? 'đ' : '$valueđ';
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
      int? num =
          int.tryParse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      if (num == null) {
        return oldValue;
      }
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
