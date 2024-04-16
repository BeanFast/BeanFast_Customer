import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../enums/menu_index_enum.dart';
import '../../utils/constants.dart';
import 'splash_screen.dart';

class DepositeScreen extends StatelessWidget {
  final DepositeController depositeController = Get.put(DepositeController());
  DepositeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Nạp tiền',
      )),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Số tiền nạp (đ)', style: Get.textTheme.titleMedium),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 55,
                          width: 110,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#26AA91")), // Text color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Background color
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10)),
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
                              depositeController.updateMoney('100.000');
                            },
                            child:
                                Text('100.000', style: Get.textTheme.bodyLarge),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                          width: 110,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#26AA91")), // Text color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Background color
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10.0)),
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
                              depositeController.updateMoney('200.000');
                            },
                            child:
                                Text('200.000', style: Get.textTheme.bodyLarge),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                          width: 110,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#26AA91")), // Text color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Background color
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10.0)),
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
                              depositeController.updateMoney('300.000');
                            },
                            child:
                                Text('300.000', style: Get.textTheme.bodyLarge),
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
                          width: 110,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#26AA91")), // Text color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Background color
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10.0)),
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
                              depositeController.updateMoney('500.000');
                            },
                            child:
                                Text('500.000', style: Get.textTheme.bodyLarge),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                          width: 110,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#26AA91")), // Text color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Background color
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10.0)),
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
                              depositeController.updateMoney('1.000.000');
                            },
                            child: Text('1.000.000',
                                style: Get.textTheme.bodyLarge),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                          width: 110,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#26AA91")), // Text color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Background color
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10.0)),
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
                              depositeController.updateMoney('2.000.000');
                            },
                            child: Text('2.000.000',
                                style: Get.textTheme.bodyLarge),
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
                            contentPadding: EdgeInsets.all(16),
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
                          onChanged: (value) => {
                                depositeController.updateMoney(value),
                              }),
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
                                  Obx(() => Text(depositeController.money.value,
                                      style: Get.textTheme.bodyLarge)),
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
            SizedBox(
              width: Get.width / 1.2,
              height: Get.height / 15,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green), // Background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                onPressed: () async {
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
                                content: const Text('Bạn có muốn thoát không?'),
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
                },
                child: Text('Nạp tiền', style: Get.textTheme.titleMedium),
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
  int moneyInt = 0;
  void updateMoney(String value) {
    if (value.isNotEmpty) {
      textController.text = value;
      moneyInt = int.parse(value.replaceAll(".", ""));
    } else {
      moneyInt = 0;
    }
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
