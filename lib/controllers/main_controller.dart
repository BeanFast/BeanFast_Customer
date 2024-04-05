import 'package:get/get.dart';

import '/utils/logger.dart';

class MainController extends GetxService {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    
  }
}