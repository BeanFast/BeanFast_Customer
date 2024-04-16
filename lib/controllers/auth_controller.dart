import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '/enums/menu_index_enum.dart';
import '/models/profile.dart';
import '/services/profile_service.dart';
import '/views/screens/splash_screen.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';
import '/services/auth_service.dart';
import '/models/account.dart';
import '/enums/auth_state_enum.dart';

class AuthController extends GetxController with CacheManager {
  late Rx<Account?> account;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  RxString errorMessage = ''.obs;
  var isPasswordVisible = true.obs;
  var isChecked = false.obs;

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

  Future login() async {
    // phoneController.text = '0372266084';
    // passwordController.text = '12345678';
    // phoneController.text = '0369998759';
    // passwordController.text = 'thanh1234';
    // phoneController.text = '0361118759';
    // passwordController.text = '12345678';
    try {
      logger.e('login');
      var response = await AuthService()
          .login(phoneController.text, passwordController.text);
      if (response.statusCode == 200) {
        changeAuthState(AuthState.authenticated);
        await saveToken(response.data['data']['accessToken']);
        changePage(MenuIndexState.home.index);
        Get.offAll(const SplashScreen());
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

  Future getCurrentUser() async {
    try {
      currentProfile.value = null;
      currentUser.value = await AuthService().getUser();
      List<Profile>? list = await ProfileService().getAll();
      if (list.isNotEmpty) {
        list.sort((a, b) => b.dob!.compareTo(a.dob!));
        currentProfile.value = currentProfile.value != null
            ? list.firstWhere((e) => e.id == currentProfile.value!.id)
            : list.first;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //---------------------------------------------------
  var isRePasswordVisible = true.obs;
  Future register() async {
    var phone = phoneController.text;
    var password = passwordController.text;
    try {
      await AuthService().register(phone, password);
      await AuthService().sendOtp(phone);
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        errorMessage.value = e.response!.data.toString();
      }
    }
    // var fullName = fullNameController.text;
  }

  // void togglePasswordVisibility() {
  //   isPasswordVisible.value = !isPasswordVisible.value;
  // }

  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  // void toggleIschecked() {
  //   isChecked.value = !isChecked.value;
  // }
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

// ignore: constant_identifier_names
enum CacheManagerKey { TOKEN }
