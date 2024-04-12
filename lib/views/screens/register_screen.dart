import 'package:animate_do/animate_do.dart';
import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/services/auth_service.dart';
import 'package:beanfast_customer/views/screens/otp_confirmation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: FadeInUp(
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Số điện thoại',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity, // Set the width
                      height: 85,
                      child: TextFormField(
                        controller: controller.phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Số điện thoại',
                          prefixIcon: Icon(Icons.phone_android_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          if (value.length < 3) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Mật khẩu',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => SizedBox(
                        width: double.infinity, // Set the width
                        height: 85,
                        child: TextFormField(
                          obscureText:
                              controller.isPasswordVisible.value,

                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            prefixIcon: const Icon(Icons.lock_outlined),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed:
                                  controller.togglePasswordVisibility,
                            ),
                          ),
                          // obscureText: _isPasswordHidden.value,
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
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Xác nhận mật khẩu',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => SizedBox(
                        width: double.infinity, // Set the width
                        height: 85,
                        child: TextFormField(
                          obscureText:
                              controller.isRePasswordVisible.value,

                          // controller: _authController.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Xác nhận mật khẩu',
                            prefixIcon: const Icon(Icons.lock_outlined),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isRePasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed:
                                  controller.toggleRePasswordVisibility,
                            ),
                          ),
                          // obscureText: _isPasswordHidden.value,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: controller.isChecked.value,
                              onChanged: (value) {
                                controller.toggleIschecked();
                              },
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Chấp nhận với điều khoản'),
                        ),
                      ],
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.errorMessage.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                              const EdgeInsets.all(10)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await controller.register();
                            Get.to(
                              () => OtpConfirmationView(),
                              binding: BindingsBuilder(() {
                                Get.put(OTPController(
                                  phone:
                                      controller.phoneController.text,
                                ));
                              }),
                            );
                          }
                        },
                        child: const Text('Đăng ký',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
