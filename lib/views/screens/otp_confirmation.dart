import 'dart:async';

import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/services/auth_service.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:beanfast_customer/views/screens/login_screen.dart';
import 'package:beanfast_customer/views/widgets/gradient_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OtpConfirmationView extends StatelessWidget {
  const OtpConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final OTPController otpController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Xác nhận OTP',
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.3,
                child: Lottie.asset(
                  "assets/otp_banner.json",
                  repeat: false,
                  animate: true,
                ),
              ),
              Text(
                'Chúng tôi đã gửi mã xác thực vào',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: Colors.black54,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${otpController.phone.substring(0, otpController.phone.length - 4)}****',
                      style: Get.textTheme.bodyLarge),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
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
                            otpController.pin1.value = value,
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
                            otpController.pin2.value = value,
                            FocusScope.of(context).nextFocus(),
                          },
                        if (value.isEmpty)
                          {
                            FocusScope.of(context).previousFocus(),
                          }
                      },
                      onSaved: (pin2) {
                        // otpController.pin2.value = pin2!;
                      },
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
                            otpController.pin3.value = value,
                            FocusScope.of(context).nextFocus(),
                          },
                        if (value.isEmpty)
                          {
                            FocusScope.of(context).previousFocus(),
                          }
                      },
                      onSaved: (pin3) {
                        // otpController.pin3.value = pin3!;
                      },
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
                            otpController.pin4.value = value,
                            FocusScope.of(context).nextFocus(),
                          },
                        if (value.isEmpty)
                          {
                            FocusScope.of(context).previousFocus(),
                          }
                      },
                      onSaved: (pin4) {
                        // otpController.pin4.value = pin4!;
                      },
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
                            otpController.pin5.value = value,
                            FocusScope.of(context).nextFocus(),
                          },
                        if (value.isEmpty)
                          {
                            FocusScope.of(context).previousFocus(),
                          }
                      },
                      onSaved: (pin5) {
                        // otpController.pin5.value = pin5!;
                      },
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
                            otpController.pin6.value = value,
                            FocusScope.of(context).unfocus()
                          },
                        if (value.isEmpty)
                          {
                            FocusScope.of(context).previousFocus(),
                          }
                      },
                      onSaved: (pin6) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('không nhận được mã?', style: Get.textTheme.bodyLarge),
                ],
              ),
              const SizedBox(height: 5),
              Obx(() => otpController.counter.value != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gửi lại sau ',
                          style: Get.textTheme.bodyMedium!.copyWith(),
                        ),
                        Obx(() {
                          final minutes = otpController.counter.value ~/ 60;
                          final seconds = otpController.counter.value % 60;
                          return Text(
                            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: ThemeColor.textButtonColor,
                            ),
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
                      child: Text(
                        'Gửi lại',
                        style: Get.textTheme.bodyLarge!.copyWith(
                          color: ThemeColor.textButtonColor,
                        ),
                      ),
                    )),
              const SizedBox(height: 60),
              GradientButton(
                text: 'Xác nhận OTP',
                onPressed: () async {
                  Get.snackbar('Hệ thống', 'Đăng ký thành công');
                  await otpController.verifyOtp();
                  Get.offAll(LoginView());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OTPController extends GetxController {
  var counter = (59).obs; // 1 minute 30 seconds
  Timer? _timer;
  RxString pin1 = "".obs;
  RxString pin2 = "".obs;
  RxString pin3 = "".obs;
  RxString pin4 = "".obs;
  RxString pin5 = "".obs;
  RxString pin6 = "".obs;
  String phone;
  OTPController({required this.phone}) {}
  Future verifyOtp() async {
    var otpValue = pin1.value +
        pin2.value +
        pin3.value +
        pin4.value +
        pin5.value +
        pin6.value;
    try {
      await AuthService().verifyOtp(phone, otpValue);
    } on DioException catch (e) {
      logger.e(e.response!.data.toString());
    }
  }

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
