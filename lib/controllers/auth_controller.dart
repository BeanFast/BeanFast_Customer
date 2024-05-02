import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '/utils/formater.dart';
import '/enums/menu_index_enum.dart';
import '/models/profile.dart';
import '/services/profile_service.dart';
import '/views/screens/splash_screen.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';
import '/services/auth_service.dart';
import '/enums/auth_state_enum.dart';

class AuthController extends GetxController with CacheManager {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken;
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
      // final expiryTimestamp = decodedToken["exp"];
      int exp = decodedToken['exp'];
      DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      if (expirationDate.isAfter(DateTime.now())) {
        changeAuthState(AuthState.authenticated);
        return;
      }
      // final currentTime = DateTime.now().millisecondsSinceEpoch;
      // if (expiryTimestamp > currentTime) {
      //   changeAuthState(AuthState.authenticated);
      //   return;
      // }
    }
    logOut();
  }

  Future login() async {
    // Get.snackbar('login', 'login');
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
      Get.snackbar('Lỗi', e.response!.data['']);
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

  Future getCurrentUser() async {
    try {
      currentUser.value = await AuthService().getUser();
      List<Profile>? list = await ProfileService().getAll();
      if (list.isNotEmpty) {
        list.sort((a, b) => b.dob!.compareTo(a.dob!));
        currentUser.value!.profiles = list;
        currentProfile.value = currentProfile.value != null
            ? list.firstWhere((e) => e.id == currentProfile.value!.id)
            : list.first;
      }
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
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

  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }
}

mixin CacheManager {
  final box = GetStorage();
  Future<bool> saveToken(String? token) async {
    await box.write(CacheManagerKey.CUSTOMERTOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    return box.read(CacheManagerKey.CUSTOMERTOKEN.toString());
  }

  Future<void> removeToken() async {
    await box.remove(CacheManagerKey.CUSTOMERTOKEN.toString());
  }

  Future<bool> saveCart(
      Map<String, Map<String, RxMap<String, RxInt>>> cart) async {
    String json = Formater.rxMapToJson(cart);
    await box.write(CacheManagerKey.CART.toString(), json);
    return true;
  }

  RxMap<String, Map<String, RxMap<String, RxInt>>>? getCart() {
    String? json = box.read(CacheManagerKey.CART.toString());
    return json == null ? null : Formater.jsonToRxMap(json);
  }

  Future<void> removeCart() async {
    await box.remove(CacheManagerKey.CART.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { CUSTOMERTOKEN, CART }
