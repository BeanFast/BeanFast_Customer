import 'package:beanfast_customer/models/food.dart';
import 'package:beanfast_customer/models/session.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:get/get.dart';

import '../models/menu.dart';
import '../models/menu_detail.dart';
import '../services/menu_service.dart';

class MenuController extends GetxController {
  List<Session> listSession = [];
  Rx<Menu> model = Menu().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxSet<String> listCategoryId = <String>{}.obs;
  RxList<MenuDetail> listCombos = <MenuDetail>[].obs;
  RxList<MenuDetail> listFoods = <MenuDetail>[].obs;

  Future getData(String schoolId) async {
    try {
      listSession = await MenuService().getSessionsBySchoolId(schoolId);
      model.value = listSession.last.menu!;
      updateFoodsAndCombos(model.value.menuDetails!);
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateFoodsAndCombos(List<MenuDetail> list) {
    listFoods.clear();
    listCombos.clear();
    for (var e in list) {
      e.food!.isCombo! ? listCombos.add(e) : listFoods.add(e);
    }
    logger.e('combos - ${listCombos.length}');
    logger.e('foods - ${listFoods.length}');
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
