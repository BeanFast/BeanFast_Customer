import 'package:get/get.dart';

import '../utils/constants.dart';
import '/models/profile.dart';
import '/services/profile_service.dart';

class ProfileController extends GetxController {
  RxList<Profile> listData = <Profile>[].obs;
  Rx<Profile> model = Profile().obs;

  Future getAll() async {
    try {
      listData.value = await ProfileService().getAll();
      if (listData.isNotEmpty) {
        listData.sort((a, b) => b.dob!.compareTo(a.dob!));
      }
      return listData;
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
