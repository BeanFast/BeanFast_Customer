import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '/utils/dialog.dart';
import '/services/auth_service.dart';
import '/services/profile_service.dart';
import '/utils/constants.dart';
import '/models/profile.dart';
import '/models/user.dart';
import '/services/user_service.dart';

class UserController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  final TextEditingController fullnameController = TextEditingController();

  RxList<Profile> dataList = <Profile>[].obs;
  Rx<User> model = User().obs;

  void createForm() {
    imagePath.value = '';
    if (currentUser.value!.fullName != null) {
      fullnameController.text = currentUser.value!.fullName!;
    }
  }

  Future fetchData() async {
    try {
      currentUser.value = await AuthService().getUser();
      List<Profile> list = await ProfileService().getAll();
      currentUser.value!.profiles = list;
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  Future<void> pickPhoto({required ImageSource source}) async {
    imagePath.value = '';
    Permission permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    var status = await permission.status;
    if (!status.isGranted) {
      status = await permission.request();
    }
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        imagePath.value = image.path;
        await DialogUtils.showConfirmationDialog(
          title: 'Xác nhận',
          content: 'Cập nhật ảnh?',
          textConfirm: 'Đồng ý',
          textCancel: 'Hủy',
          onConfirm: () async {
            await updateImage();
          },
        );
      } else {
        Get.snackbar('Thông báo', 'Chưa có ảnh');
      }
    }
  }

  Future updateImage() async {
    if (imagePath.value.isEmpty) {
      Get.snackbar('Lỗi', 'Chưa có ảnh');
      return;
    }
    model.value.avatarPath = imagePath.value;
    try {
      model.value.fullName = currentUser.value!.fullName;
      await UserService().updateUser(model.value);
      Get.snackbar('Thông báo', 'Thành công');
      await fetchData();
    } catch (e) {
      Get.snackbar('Lỗi', 'Cập nhật thất bại');
    }
  }

  Future submitForm() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Lỗi', 'Thông tin chưa chính xác');
      return;
    }
    try {
      model.value.fullName = fullnameController.text.trim().capitalize;
      await UserService().updateUser(model.value);
      Get.snackbar('Thông báo', 'Thành công');
      await fetchData();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data.toString());
    }
  }
}
