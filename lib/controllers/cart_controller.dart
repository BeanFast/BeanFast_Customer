import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt itemCount = 0.obs;
  RxMap<String, int> quantities = <String, int>{}.obs;
  

  void increase(String itemId) {
    if (quantities[itemId] != null) {
      quantities.update(itemId, (value) => value + 1);
    } else {
      quantities[itemId] = 1;
    }
  }

  void decrease(String itemId) {
    if (quantities[itemId] != null && quantities[itemId]! > 1) {
      quantities.update(itemId, (value) => value - 1);
    }
  }
}
