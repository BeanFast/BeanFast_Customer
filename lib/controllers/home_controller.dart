import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/menu_detail.dart';
import '/models/menu.dart';
import '/models/session.dart';
import '/services/session_service.dart';
import '/models/profile.dart';
import '/services/profile_service.dart';
import '/utils/logger.dart';

class MenuModel {
  List<MenuDetail> listDiscountedCombo = [];
  List<MenuDetail> listDiscountedFood = [];
  List<MenuDetail> listCombo = [];
  List<MenuDetail> listFood = [];
  final Map<String, String> listCategories = {};
}

class HomeController extends GetxController {
  RxList<Profile> listProfile = <Profile>[].obs;
  RxList<Session> listSession = <Session>[].obs;
  Rx<MenuModel> menuModel = MenuModel().obs;
  Rx<Menu> model = Menu().obs;
  Rx<String> selectedSessionId = ''.obs;
  // RxSet<String> listCategoryId = <String>{}.obs;
  RxString selectedCategoryId = ''.obs;

  Future getProfiles() async {
    try {
      listProfile.value = await ProfileService().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getSession(String schoolId, DateTime dateTime) async {
    try {
      listSession.value =
          await SessionService().getSessionsBySchoolId(schoolId, dateTime);

      // model.value = listSession.last.menu!;
      // updateFoodsAndCombos(model.value.menuDetails!);
      logger.e(listSession.length);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  void getMenu(String id) {
    model.value = listSession.where((e) => e.id! == id).first.menu!;
    updateFoodsAndCombos(model.value.menuDetails!);
  }

  void updateFoodsAndCombos(List<MenuDetail> list) {
    MenuModel model = MenuModel();
    for (var e in list) {
      model.listCategories
          .putIfAbsent(e.food!.category!.name!, () => e.food!.category!.name!);
      if (e.food!.price != e.price) {
        e.food!.isCombo!
            ? model.listDiscountedCombo.add(e)
            : model.listDiscountedFood.add(e);
      } else {
        e.food!.isCombo! ? model.listCombo.add(e) : model.listFood.add(e);
      }
    }
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
