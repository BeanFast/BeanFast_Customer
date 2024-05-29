import 'package:beanfast_customer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '/models/bmi.dart';
import '/services/profile_service.dart';
import '/services/school_service.dart';
import '/models/profile.dart';
import '/models/school.dart';
import '/utils/logger.dart';
import 'profile_controller.dart';

class ProfileFormController extends GetxController {
  Rx<Profile> model = Profile().obs;
  Rx<bool> isImageFile = true.obs;
  RxBool isSubmitting = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  var gender = 'Nam'.obs;
  Rx<DateTime> selectedDate =
      DateTime.now().subtract(const Duration(days: 4 * 365)).obs;
  Rx<School?> selectedSchool = Rx<School?>(null);
  List<School> listSchool = [];
  RxList<School> filteredSchools = <School>[].obs;
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  Future getProfileById(String id) async {
    try {
      Profile profile = await ProfileService().getById(id);
      imagePath.value = profile.avatarPath.toString();
      fullnameController.text = profile.fullName.toString();
      nickNameController.text = profile.nickName.toString();
      selectedDate.value = profile.dob!;
      selectedSchool.value = profile.school;
      classController.text = profile.className.toString();
      gender.value = profile.gender == true ? 'Nam' : 'Nữ';
      //default image
      model.value.id = profile.id;
      model.value.avatarPath = profile.avatarPath.toString();
      isImageFile.value = false;
    } on dio.DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  Future getSchools() async {
    filteredSchools.clear();
    try {
      listSchool = await SchoolService().getAll();
      filteredSchools.addAll(listSchool);
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  Future<void> pickPhotoFormCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      isImageFile.value = true;
      imagePath.value = image.path;
      logger.e(image.path);
      Get.back();
    } else {
      logger.e('No picture taken.');
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
        isImageFile.value = true;
        imagePath.value = image.path;
        logger.e(image.path);
        Get.back();
      } else {
        Get.snackbar('Thông báo', 'No image selected.');
      }
    }
  }

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
  );

  void updateFilteredSchools([String? searchQuery]) {
    filteredSchools.clear();
    if (searchQuery != null && searchQuery.isNotEmpty) {
      var list = listSchool
          .where((school) =>
              school.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      filteredSchools.addAll(list);
    } else {
      filteredSchools.addAll(listSchool);
    }
  }

  Future<void> submitForm(bool isUpdate) async {
    if (imagePath.value.isEmpty) {
      Get.snackbar('Lỗi', 'Chưa có ảnh');
      return;
    }
    if (selectedSchool.value == null) {
      Get.snackbar('Lỗi', 'Vui lòng chọn trường');
      return;
    }
    if (formKey.currentState!.validate()) {
      isSubmitting.value = true;
      try {
        //form
        model.value.fullName = fullnameController.text.trim().capitalize;
        model.value.nickName = nickNameController.text.trim().capitalize;
        model.value.className = classController.text.trim().capitalize;
        model.value.dob = selectedDate.value;

        model.value.bmis = [Bmi()];
        model.value.bmis!.last.height = double.parse(heightController.text);
        model.value.bmis!.last.weight = double.parse(weightController.text);
        model.value.bmis!.last.age =
            DateTime.now().year - model.value.dob!.year;
        model.value.school = School();
        model.value.school!.id = selectedSchool.value!.id!;
        model.value.gender = gender.value == 'Nam' ? true : false;
        //
        if (isUpdate) {
          bool isUpdateImage = model.value.avatarPath != imagePath.value;
          if (isUpdateImage) {
            model.value.avatarPath = imagePath.value;
          }
          await ProfileService().update(model.value, isUpdateImage);
        } else {
          model.value.avatarPath = imagePath.value;
          await ProfileService().create(model.value);
        }
        if (model.value.id != null) {
          Get.find<ProfileController>().getById(model.value.id!);
        } else {
          Get.find<ProfileController>().getAll();
        }
        if (currentProfile.value == null) {
          Get.find<ProfileController>().getCurrentProfile();
        }
        Get.back();
      } on dio.DioException catch (e) {
        Get.snackbar('Lỗi', e.message.toString());
      } finally {
        isSubmitting.value = false;
      }
    } else {
      Get.snackbar('Lỗi', 'Thông tin chưa chính xác');
    }
  }

  Future<void> deleteById(String id) async {
    try {
      dio.Response response = await ProfileService().deleteById(id);
      if (response.statusCode == 200) {
        Get.back();
      } else {
        Get.snackbar('Lỗi', response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
