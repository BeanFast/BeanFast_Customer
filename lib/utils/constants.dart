import 'package:get/get.dart';

import '../services/api_service.dart';
import '/enums/menu_index_enum.dart';
import '/enums/auth_state_enum.dart';
import '/models/user.dart';
import '/models/profile.dart';

Rx<User?> currentUser = Rx<User?>(null);
Rx<Profile?> currentProfile = Rx<Profile?>(null);
final ApiService apiService = Get.find();
RxInt selectedMenuIndex = MenuIndexState.home.index.obs;
Rx<AuthState> authState = AuthState.unauthenticated.obs;

void changePage(int index) {
  selectedMenuIndex.value = index;
}

List<Map<String, dynamic>> get cancelOrderReasonOptions => [
      {'value': 0, 'title': 'Đặt nhầm món'},
      {'value': 1, 'title': 'Thay đổi kế hoạch'},
      {'value': 2, 'title': 'Không liên hệ được với quán'},
      {'value': 3, 'title': 'Lý do khác'},
    ];

List<Map<String, dynamic>> get cancelExchangeGiftReasonOptions => [
      {'title': 'Đặt nhầm quà', 'value': 0},
      {'title': 'Thay đổi kế hoạch', 'value': 1},
      {'title': 'Không liên hệ được với quán', 'value': 2},
      {'title': 'Lý do khác', 'value': 3},
    ];
