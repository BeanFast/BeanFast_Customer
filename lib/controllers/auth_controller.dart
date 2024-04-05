import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/constants.dart';
import '../utils/formater.dart';
import '../utils/logger.dart';
import '/services/auth_service.dart';
import '/models/account.dart';
import '/enums/auth_state_enum.dart';

class AuthController extends GetxController with CacheManager {
  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* đ'.obs;

  

  late Rx<Account?> account;
  Rx<AuthState> authState = AuthState.unauthenticated.obs;
  // final RxBool logged = false.obs;

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

  // final _authState = Rx<AuthState>(AuthState.unknown);

  // Stream<AuthState> get authStateChanges => _authState.stream;
  void changeAuthState(AuthState newState) {
    authState.value = newState;
  }

  void checkLoginStatus() {
    final token = getToken();
    token != null
        ? changeAuthState(AuthState.authenticated)
        : changeAuthState(AuthState.unauthenticated);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   firebaseUser = Rx<User?>(auth.currentUser);
  //   firebaseUser.bindStream(auth.userChanges());

  //   ever(firebaseUser, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user != null) {
  //     // user is logged in
  //     Get.offAll(() => const Home());
  //   } else {
  //     // user is null as in user is not available or not logged in
  //     Get.offAll(() => Login());
  //   }
  // }

  // void register(String email, String password) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     // this is solely for the Firebase Auth Exception
  //     // for example : password did not match
  //     print(e.message);
  //     // Get.snackbar("Error", e.message!);
  //     Get.snackbar(
  //       "Error",
  //       e.message!,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } catch (e) {
  //     // this is temporary. you can handle different kinds of activities
  //     //such as dialogue to indicate what's wrong
  //     print(e.toString());
  //   }
  // }

  // void login(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     // this is solely for the Firebase Auth Exception
  //     // for example : password did not match
  //     print(e.message);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  

  void login() async {
    phoneController.text = '0372266084';
    passwordController.text = '12345678';
    try {
      logger.e('login');
      var response = await AuthService()
          .login(phoneController.text, passwordController.text);
      if (response.statusCode == 200) {
        removeToken();
        changeAuthState(AuthState.authenticated);
        await saveToken(response.data['data']['accessToken']); //Token is cached
      }
    } catch (e) {
      errorMessage.value = 'Số điện thoại hoặc mật khẩu không đúng';
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
