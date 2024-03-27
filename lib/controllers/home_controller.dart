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
}
