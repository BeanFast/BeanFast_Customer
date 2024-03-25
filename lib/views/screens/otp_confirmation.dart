import 'dart:async';

import 'package:beanfast_customer/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpConfirmationView extends StatelessWidget {
  final OTPController otpController = Get.find();
  OtpConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Xác nhận OTP',
          
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Chúng tôi đã gửi mã xác thực vào',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '+84 966324***',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Thay đổi số điện thoại?'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => {
                          if (value.isNotEmpty)
                            {
                              FocusScope.of(context).nextFocus(),
                            }
                        },
                        onSaved: (pin1) {},
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => {
                          if (value.isNotEmpty)
                            {
                              FocusScope.of(context).nextFocus(),
                            },
                          if (value.isEmpty)
                            {
                              FocusScope.of(context).previousFocus(),
                            }
                        },
                        onSaved: (pin2) {},
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => {
                          if (value.isNotEmpty)
                            {
                              FocusScope.of(context).nextFocus(),
                            },
                          if (value.isEmpty)
                            {
                              FocusScope.of(context).previousFocus(),
                            }
                        },
                        onSaved: (pin3) {},
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => {
                          if (value.isNotEmpty)
                            {
                            FocusScope.of(context).unfocus()
                            },
                          if (value.isEmpty)
                            {
                              FocusScope.of(context).previousFocus(),
                            }
                        },
                        onSaved: (pin4) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('không nhận được mã?', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 5),
                Obx(() => otpController.counter.value != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gửi lại sau ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Obx(() {
                            final minutes = otpController.counter.value ~/ 60;
                            final seconds = otpController.counter.value % 60;
                            return Text(
                              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 16, color: Colors.green),
                            );
                          }),
                        ],
                      )
                    : TextButton(
                        onPressed: otpController.counter.value == 0
                            ? () {
                                Get.snackbar(
                                  'BeanFast', // title
                                  'Đã gửi lại OTP', // message
                                  icon: const Icon(Icons.notifications),
                                  shouldIconPulse: true,
                                  onTap: (val) {
                                    // handle the tap
                                  },
                                  barBlur: 20,
                                  isDismissible: true,
                                  duration: const Duration(seconds: 3),
                                );
                                otpController.startTimer();
                              }
                            : () {
                                final minutes = otpController.counter.value ~/ 60;
                                final seconds = otpController.counter.value % 60;
                                Get.snackbar(
                                  'BeanFast', // title
                                  'Vui lòng đợi trong ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} để nhận được mã mới', // message
                                  icon: const Icon(Icons.notifications),
                                  shouldIconPulse: true,
                                  onTap: (val) {
                                    // handle the tap
                                  },
                                  barBlur: 20,
                                  isDismissible: true,
                                  duration: const Duration(seconds: 3),
                                );
                              },
                        child: const Text('Gửi lại',
                            style: TextStyle(fontSize: 16, color: Colors.green)),
                      )),
                const SizedBox(height: 60),
                SizedBox(
                  height: 64,
                  width: MediaQuery.of(context).size.width,
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
                    onPressed: () {
                      Get.off(LoginView());
                    },
                    child: const Text('Xác nhận OTP',
                        style: TextStyle(fontSize: 18)),
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

class OTPController extends GetxController {
  var counter = (59).obs; // 1 minute 30 seconds
  Timer? _timer;

  void startTimer() {
    counter.value = 59;
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value > 0) {
        counter.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
