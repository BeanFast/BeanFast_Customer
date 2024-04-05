import 'package:get/get.dart';

import '/enums/menu_index_enum.dart';
import '/models/user.dart';
import '/models/profile.dart';

Rx<User> currentUser = User().obs;
Rx<Profile> currentProfile = Profile().obs;
RxInt selectedMenuIndex = MenuIndexState.home.index.obs;

void changePage(int index) {
  selectedMenuIndex.value = index;
}
