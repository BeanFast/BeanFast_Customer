import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '/utils/cache_manager.dart';
import '/enums/menu_index_enum.dart';
import '/views/screens/splash_screen.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';
import '/services/auth_service.dart';
import '/enums/auth_state_enum.dart';

class AuthController extends GetxController with CacheManager {
  RxBool isSubmitting = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken;
  RxString errorMessage = ''.obs;

  var isChecked = false.obs;
  RxInt playTimes = 0.obs;

  var islogoinPasswordVisible = false.obs;
  void toggleLoginPasswordVisibility() {
    islogoinPasswordVisible.value = !islogoinPasswordVisible.value;
  }

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isRePasswordVisible = false.obs;
  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  void toggleIschecked() {
    isChecked.value = !isChecked.value;
  }

  void changeAuthState(AuthState newState) {
    authState.value = newState;
  }

  Future getUser() async {
    try {
      currentUser.value = await AuthService().getUser();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  void checkLoginStatus() {
    final String? token = getToken();
    logger.e('token - ${token != null}');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // final expiryTimestamp = decodedToken["exp"];
      int exp = decodedToken['exp'];
      DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      if (expirationDate.isAfter(DateTime.now())) {
        changeAuthState(AuthState.authenticated);
        return;
      }
    }
    logOut();
  }

  Future login() async {
    isSubmitting.value = true;
    try {
      logger.e('login');
      deviceToken = await _firebaseMessaging.getToken();
      var response = await AuthService()
          .login(phoneController.text, passwordController.text, deviceToken!);
      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Đăng nhập thành công');
        changeAuthState(AuthState.authenticated);
        await saveToken(response.data['data']['accessToken']);
        changePage(MenuIndexState.home.index);
        Get.offAll(const SplashScreen());
      }
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response?.data['message'] ?? '');
    } finally {
      isSubmitting.value = false;
    }
  }

  void clear() {
    currentUser.value = null;
    currentProfile.value = null;
  }

  void logOut() {
    clear();
    changeAuthState(AuthState.unauthenticated);
    removeToken();
  }

  //---------------------------------------------------

  Future register() async {
    var phone = phoneController.text;
    var password = passwordController.text;
    isSubmitting.value = true;
    try {
      await AuthService().register(phone, password);
      await AuthService().sendOtp(phone);
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response?.data['message'] ?? '');
      // if (e.response!.statusCode == 400) {
      //   errorMessage.value = e.response!.data.toString();
      // }
      rethrow;
    } finally {
      isSubmitting.value = false;
    }
    // var fullName = fullNameController.text;
  }
}
