import 'package:get/get.dart';

import '../models/menu.dart';
import '../services/menu_service.dart';

class MenuController extends GetxController {
  Rx<Menu> listData = Menu().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future getData(String schoolId) async {
    try {
      listData.value = await MenuService().getBySchoolId(schoolId);
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  RxInt selectedIndex = 0.obs;

  static const int saleItem = 3;
  RxInt selectedDiscountIndex = 0.obs;

  var amountsSale1 =
      List<int>.filled(saleItem, 0).obs; // replace 10 with the number of items

  void increaseAmountSale1(int index) {
    amountsSale1[index]++;
  }

  void decreaseAmountSale1(int index) {
    if (amountsSale1[index] > 0) {
      amountsSale1[index]--;
    }
  }

  static const int category1Item = 4;
  RxInt selectedCategory1Index = 0.obs;

  var amountsCate1 = List<int>.filled(category1Item, 0)
      .obs; // replace 10 with the number of items

  void increaseAmountCate1(int index) {
    amountsCate1[index]++;
  }

  void decreaseAmountCate1(int index) {
    if (amountsCate1[index] > 0) {
      amountsCate1[index]--;
    }
  }
}