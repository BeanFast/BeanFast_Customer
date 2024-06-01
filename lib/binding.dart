import 'package:get/get.dart';

import '/services/api_service.dart';
import 'controllers/user_controller.dart';
import 'controllers/auth_controller.dart';

class MainBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ApiService>(() => ApiService());
    Get.put<UserController>(UserController(), permanent: true);
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.put<HomeController>(HomeController(), permanent: true);
  }
}
