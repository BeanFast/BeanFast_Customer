import 'package:beanfast_customer/models/profile.dart';
import 'package:get/get.dart';

import '../services/profile_service.dart';

class ProfileController extends GetxController {
  RxString imagePath = ''.obs;

  RxList<Profile> listData = <Profile>[].obs;
  Rx<Profile> model = Profile().obs;

  // Future<void> pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imagePath.value = pickedFile.path;
  //   }
  //   logger.i(imagePath.value);
  // }

  Future getData() async {
    try {
      listData.value = await ProfileService().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getById(String id) async {
    try {
      model.value = await ProfileService().getById(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
