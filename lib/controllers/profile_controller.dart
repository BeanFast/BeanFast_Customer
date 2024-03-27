// import 'dart:io';

import 'package:beanfast_customer/models/profile.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../services/profile_service.dart';
import '../utils/logger.dart';

class ProfileController extends GetxController {
  RxString imagePath = ''.obs;
  RxList<String> messageErrors = <String>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Profile> listData = <Profile>[].obs;
  Rx<Profile> model = Profile().obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
    logger.i(imagePath.value);
  }

  void submitForm() {
    messageErrors.value = [];

    // model.value.bmis!.last.age = DateTime.now().year - model.value.dob!.year;
    model.value.avatarPath = imagePath.value;
    if (formKey.currentState!.validate() && imagePath.value.isNotEmpty) {
      // Food food = Food(
      //     name: foodName.text,
      //     price: Formatter.formatPriceToDouble(foodPrice.text),
      //     categoryId: foodCategory.value!.id,
      //     imagePath: imagePath.value);
      // model.value = food;
      // logger.i(foodCategory.value!.id);
      // logger.i(model);
      // Get.back();

      // Thêm các trường khác của form-data nếu cần
      return;
    }
    if (imagePath.value.isEmpty) messageErrors.add('Ảnh trống');
  }

  Future getData() async {
    try {
      listData.value = await ProfileService().getAll();
    } catch (e) {
      logger.e(e);
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
