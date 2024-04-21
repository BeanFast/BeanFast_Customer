import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/views/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '/controllers/auth_controller.dart';
import '/views/screens/register_screen.dart';

class LoginView extends GetView<AuthController> {
  final AuthController _authController = Get.put(AuthController());
  final Duration duration = const Duration(milliseconds: 800);
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng Nhập',
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.2,
                child: Lottie.asset(
                  "assets/login.json",
                  animate: true,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    FadeInUp(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Số điện thoại',
                          style: Get.textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: SizedBox(
                        child: TextFormField(
                          controller: _authController.phoneController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số diện thoại';
                            }
                            if (value.length < 10) {
                              return 'Số điện thoại có độ dài ít nhất là 10';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mật khẩu',
                          style: Get.textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: Obx(
                        () => SizedBox(
                          child: TextFormField(
                            controller: _authController.passwordController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outlined),
                              border: const UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () {
                                  controller.togglePasswordVisibility();
                                },
                              ),
                            ),
                            obscureText: controller.isPasswordVisible.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu';
                              }
                              if (value.length < 8) {
                                return 'Mật khẩu phải có ít nhất 8 ký tự';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeInUp(
                      child: Obx(
                        () => Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // FadeInUp(
                    //   child: Row(
                    //     children: [
                    //       Obx(
                    //         () => SizedBox(
                    //           height: 24,
                    //           width: 24,
                    //           child: Checkbox(
                    //             value: controller.isChecked.value,
                    //             onChanged: (value) {
                    //               controller.toggleIschecked();
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       const Text('Giữ đăng nhập'),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    FadeInUp(
                      child: GradientButton(
                        text: 'Đăng nhập',
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            controller.errorMessage.value = '';
                          }
                          if (_formKey.currentState!.validate()) {
                            controller.errorMessage.value = '';
                            _authController.login();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInUp(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Chưa có tài khoản?'),
                          TextButton(
                            onPressed: () {
                              Get.to(RegisterView());
                            },
                            child: const Text('Đăng ký'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
