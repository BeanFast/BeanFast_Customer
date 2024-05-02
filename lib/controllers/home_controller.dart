import 'package:beanfast_customer/services/auth_service.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '/utils/constants.dart';
import '/utils/formater.dart';
import '/models/menu_detail.dart';
import '/models/menu.dart';
import '/models/session.dart';
import '/services/session_service.dart';
import '/models/profile.dart';
import '/services/profile_service.dart';

class MenuModel {
  List<MenuDetail> listDiscountedCombo = [];
  List<MenuDetail> listDiscountedFood = [];
  List<MenuDetail> listCombo = [];
  List<MenuDetail> listFood = [];
}

class HomeController extends GetxController {
  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* đ'.obs;
  //
  RxList<Profile> listProfile = <Profile>[].obs;
  RxList<Session> listSession = <Session>[].obs;
  Rx<MenuModel> menuModel = MenuModel().obs;
  Rx<String> selectedSessionId = ''.obs;
  RxString selectedCategoryId = 'Tất cả'.obs;
  List<String> listCategories = [];

  Future getProfiles() async {
    try {
      List<Profile> list = await ProfileService().getAll();
      if (currentProfile.value != null) {
        var profileIndex =
            list.indexWhere((e) => e.id == currentProfile.value!.id);
        if (profileIndex != -1) {
          var profile = list[profileIndex];
          list.removeAt(profileIndex);
          list.insert(0, profile);
        }
      }
      listProfile.value = list;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> toggleMoneyVisibility() async {
    try {
      currentUser.value = await AuthService().getUser();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value = isMoneyVisible.value
        ? Formater.formatMoney(currentUser.value!.balance.toString())
        : '********* đ';
  }

  void clear() {
    listSession.clear();
    menuModel.value = MenuModel();
    listCategories.clear();
    selectedSessionId.value = '';
    selectedCategoryId.value = '';
  }

  Future getSession(String schoolId, DateTime dateTime) async {
    clear();
    try {
      listSession.value =
          await SessionService().getSessionsBySchoolId(schoolId, dateTime);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  void sortByCategory(String value) {
    Menu menu =
        listSession.where((e) => e.id! == selectedSessionId.value).first.menu!;
    List<MenuDetail> list = menu.menuDetails!;
    if (value != 'Tất cả') {
      list = menu.menuDetails!
          .where((item) => item.food!.category!.name == value)
          .toList();
    }
    updateMenu(list);
  }

  void getMenu(String id) {
    Menu menu = listSession.where((e) => e.id! == id).first.menu!;
    if (!listCategories.contains('Tất cả')) {
      listCategories.add('Tất cả');
    }
    selectedCategoryId.value = 'Tất cả';
    for (var menuDetail in menu.menuDetails!) {
      if (!listCategories.contains(menuDetail.food!.category!.name!)) {
        listCategories.add(menuDetail.food!.category!.name!);
      }
    }
    updateMenu(menu.menuDetails!);
  }

  void updateMenu(List<MenuDetail> list) {
    MenuModel model = MenuModel();
    for (var e in list) {
      if (e.food!.price != e.price) {
        e.food!.isCombo!
            ? model.listDiscountedCombo.add(e)
            : model.listDiscountedFood.add(e);
      } else {
        e.food!.isCombo! ? model.listCombo.add(e) : model.listFood.add(e);
      }
    }
    model.listDiscountedCombo.addAll(model.listCombo);
    menuModel.value = model;
  }

//------------------------------------------------------------------------
  Rx<DateTime> now = DateTime.now().obs;

  void nextWeek() {
    now.value = now.value.add(const Duration(days: 7));
  }

  void backWeek() {
    now.value = now.value.subtract(const Duration(days: 7));
  }

  RxInt dayOfWeek(int index) {
    int currentDayIndex = now.value.weekday - 1;
    int difference = index - currentDayIndex;
    return now.value.add(Duration(days: difference)).day.obs;
  }

  Rx<DateTime> dayOfWeekDateTime(int index) {
    int currentDayIndex = now.value.weekday - 1;
    int difference = index - currentDayIndex;
    return now.value.add(Duration(days: difference)).obs;
  }

  RxInt get currentMonth => now.value.month.obs;
  RxInt get currentYear => now.value.year.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    //
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
