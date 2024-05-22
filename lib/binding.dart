import 'package:get/get.dart';

import '/services/api_service.dart';
import 'controllers/home_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/user_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/notification_controller.dart';

class MainBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ApiService>(() => ApiService());
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
