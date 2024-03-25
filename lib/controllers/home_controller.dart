import 'package:get/get.dart';

class HomeController extends GetxController {
  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* VND'.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value =
        isMoneyVisible.value ? '78.967.000.000đ' : '*********đ';
  }
}