import 'package:beanfast_customer/views/screens/otp_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  // SizedBox(
                  //   width: double.infinity, // Set the width
                  //   height: 85,
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       labelText: 'Tên đăng nhập',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Vui lòng nhập tên đăng nhập';
                  //       }
                  //       if (value.length < 3) {
                  //         return 'Tên đăng nhập phải có ít nhất 3 ký tự';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  // SizedBox(
                  //   width: double.infinity, // Set the width
                  //   height: 85,
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       labelText: 'Email',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //     validator: (value) {
                  //       RegExp regex = RegExp(
                  //           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                  //       if (!regex.hasMatch(value!)) {
                  //         return 'Email không hợp lệ';
                  //       } else {
                  //         return null;
                  //       }
                  //     },
                  //   ),
                  // ),
    
                  SizedBox(
                    width: double.infinity, // Set the width
                    height: 85,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
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
                  Obx(
                    () => SizedBox(
                      width: double.infinity, // Set the width
                      height: 85,
                      child: TextFormField(
                        obscureText: registerController.isPasswordVisible.value,

                        // controller: _authController.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              registerController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                registerController.togglePasswordVisibility,
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
                  Obx(
                    () => SizedBox(
                      width: double.infinity, // Set the width
                      height: 85,
                      child: TextFormField(
                        obscureText:
                            registerController.isRePasswordVisible.value,

                        // controller: _authController.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              registerController.isRePasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                registerController.toggleRePasswordVisibility,
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
                    children: [
                      Obx(
                        () => SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: registerController.isChecked.value,
                            onChanged: (value) {
                              registerController.toggleIschecked();
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Your onPressed code for "Show điều khoản" here
                        },
                        child: const Text('Chấp nhận với điều khoản'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, do something
                        }
                        Get.to(
                          () => OtpConfirmationView(),
                          binding: BindingsBuilder(() {
                            Get.put(OTPController());
                          }),
                        );
                      },
                      child: const Text('Đăng ký', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class RegisterController extends GetxController {
  var isPasswordVisible = true.obs;
  var isRePasswordVisible = true.obs;
  var isChecked = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  void toggleIschecked() {
    isChecked.value = !isChecked.value;
  }
}
