import 'package:get/get.dart';

import '../utils/constants.dart';
import '/models/profile.dart';
import '/services/profile_service.dart';

class ProfileController extends GetxController {
  RxList<Profile> dataList = <Profile>[].obs;
  Rx<Profile?> model = Rx<Profile?>(null);

  Future getAll() async {
    try {
      dataList.value = await ProfileService().getAll();
      if (dataList.isNotEmpty) {
        dataList.sort((a, b) => b.dob!.compareTo(a.dob!));
      }
      return dataList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getCurrentProfile() async {
    try {
      List<Profile>? list = await ProfileService().getAll();
      if (list.isNotEmpty) {
        list.sort((a, b) => b.dob!.compareTo(a.dob!));
        currentProfile.value = currentProfile.value != null
            ? list.firstWhere((e) => e.id == currentProfile.value!.id)
            : list.first;
      }
      return currentProfile;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getById(String id) async {
    try {
      model.value = await ProfileService().getById(id);
      return model.value;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future getCurrentProfile(String id) async {
  //   try {
  //     currentProfile.value = await ProfileService().getById(id);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
