import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '/utils/constants.dart';
import '/utils/formater.dart';
import '/utils/logger.dart';
import '/services/auth_service.dart';
import '/models/account.dart';
import '/enums/auth_state_enum.dart';

class AuthController extends GetxController with CacheManager {
  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* đ'.obs;

  late Rx<Account?> account;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  RxString errorMessage = ''.obs;
  var isPasswordVisible = true.obs;
  var isChecked = false.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value = isMoneyVisible.value
        ? Formater.formatMoney(currentUser.value.balance.toString())
        : '********* đ';
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleIschecked() {
    isChecked.value = !isChecked.value;
  }

  void changeAuthState(AuthState newState) {
    authState.value = newState;
  }

  void checkLoginStatus() {
    final String? token = getToken();
    logger.e('token - ${token != null}');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final expiryTimestamp = decodedToken["exp"];
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (expiryTimestamp < currentTime) {
        changeAuthState(AuthState.authenticated);
        return;
      }
    }
    logOut();
  }

  void login() async {
    phoneController.text = '0372266084';
    passwordController.text = '12345678';
    try {
      logger.e('login');
      var response = await AuthService()
          .login(phoneController.text, passwordController.text);
      if (response.statusCode == 200) {
        changeAuthState(AuthState.authenticated);
        await saveToken(response.data['data']['accessToken']); //Token is cached
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        errorMessage.value = 'Tài khoản hoặc mật khẩu không đúng';
      }
    }
  }

  void logOut() {
    changeAuthState(AuthState.unauthenticated);
    removeToken();
  }
}

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }
}

enum CacheManagerKey { TOKEN }
