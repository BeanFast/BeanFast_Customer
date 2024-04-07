import 'package:get/get.dart';

import '/models/profile.dart';
import '/services/profile_service.dart';

class HomeController extends GetxController {
  RxList<Profile> listProfile = <Profile>[].obs;

  Future getProfiles() async {
    try {
      listProfile.value = await ProfileService().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

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
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  var selectedSession = 0.obs;
}
