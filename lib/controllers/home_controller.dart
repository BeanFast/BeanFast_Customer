import 'package:get/get.dart';

import '../models/profile.dart';
import '../services/profile_service.dart';

class HomeController extends GetxController {
  var isMoneyVisible = false.obs;
  
  RxString moneyValue = '********* VND'.obs;
  RxList<Profile> listProfile = <Profile>[].obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value =
        isMoneyVisible.value ? '78.967.000.000đ' : '*********đ';
  }

  Future getProfiles() async {
    try {
      listProfile.value = await ProfileService().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }
}