import 'package:beanfast_customer/controllers/auth_controller.dart';
import 'package:beanfast_customer/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '/models/profile.dart';
import '/models/user.dart';
import '/services/user_service.dart';

class UserController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  final TextEditingController fullnameController = TextEditingController();

  RxList<Profile> listData = <Profile>[].obs;
  Rx<User> model = User().obs;

  Future<void> pickPhotoFormCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath.value = image.path;
      // logger.e(image.path);
      Get.back();
      await updateImage();
    } else {
      Get.snackbar('Thông báo', 'Chưa có ảnh');
    }
  }

  Future<void> pickPhotoFormStorage() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath.value = image.path;
        // logger.e(image.path);
        Get.back();
        await updateImage();
      } else {
        Get.snackbar('Thông báo', 'Chưa có ảnh');
      }
    }
  }

  Future updateImage() async {
    if (imagePath.value.isEmpty) Get.snackbar('Lỗi', 'Chưa có ảnh');
    model.value.avatarPath = imagePath.value;
    try {
      model.value.fullName = currentUser.value!.fullName;
      await UserService().updateUser(model.value);
      await AuthController().getCurrentUser();
      Get.snackbar('Thông báo', 'Thành công');
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  Future submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        model.value.fullName = fullnameController.text.trim();
        await UserService().updateUser(model.value);
        await AuthController().getCurrentUser();
        Get.snackbar('Thông báo', 'Thành công');
      } on DioException catch (e) {
        Get.snackbar('Lỗi', e.response!.data['message']);
      }
    } else {
      Get.snackbar('Lỗi', 'Thông tin chưa chính xác');
    }
  }
}
