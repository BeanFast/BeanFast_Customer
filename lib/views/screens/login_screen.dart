import 'package:beanfast_customer/views/screens/main_screen.dart';
import 'package:beanfast_customer/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController _authController = Get.find();
  final LoginController loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng Nhập',
          style: TextStyle(
            fontSize: 30,
          ),
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
                    controller: _authController.usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên đăng nhập',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên đăng nhập';
                      }
                      if (value.length < 3) {
                        return 'Tên đăng nhập phải có ít nhất 3 ký tự';
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
                            loginController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            loginController.togglePasswordVisibility();
                          },
                        ),
                      ),
                      obscureText: loginController.isPasswordVisible.value,
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: loginController.isChecked.value,
                          onChanged: (value) {
                            loginController.toggleIschecked();
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
                      if (_formKey.currentState!.validate()) {}
                      Get.offAll(const MainScreen());
                      // _authController.login();
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

class LoginController extends GetxController {
  var isPasswordVisible = true.obs;
  var isChecked = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleIschecked() {
    isChecked.value = !isChecked.value;
  }
}
