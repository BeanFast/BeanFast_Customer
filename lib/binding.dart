import 'package:beanfast_customer/controllers/cart_controller.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';
import '/services/api_service.dart';

class AuthBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<CartController>(() => CartController());
  }
}
class HomeBindingController extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}