import 'package:get/get.dart';

import '/enums/menu_index_enum.dart';
import '/enums/auth_state_enum.dart';
import '/models/user.dart';
import '/models/profile.dart';

Rx<User?> currentUser = Rx<User?>(null);
Rx<Profile?> currentProfile = Rx<Profile?>(null);
// Rx<Profile> currentProfile = Profile().obs;
RxInt selectedMenuIndex = MenuIndexState.home.index.obs;
Rx<AuthState> authState = AuthState.unauthenticated.obs;

void changePage(int index) {
  selectedMenuIndex.value = index;
}
