import 'package:beanfast_customer/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final AuthController _authController = Get.put(AuthController());

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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // Set the width
                  height: 85,
                  child: TextFormField(
                    controller: _authController.phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(),
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
                const SizedBox(height: 5),
                Obx(
                  () => SizedBox(
                    width: double.infinity, // Set the width
                    height: 85,
                    child: TextFormField(
                      controller: _authController.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                Obx(() => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                )),
                const SizedBox(height: 20),
                Row(
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
                    const Text('Lưu mật khẩu'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Your onPressed code for "Forgot Password" here
                      },
                      child: const Text('Quên mật khẩu?'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                        _authController.login();
                      // }
                    },
                    child:
                        const Text('Đăng nhập', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
