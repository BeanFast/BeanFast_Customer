import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '/models/bmi.dart';
import '/services/profile_service.dart';
import '/services/school_service.dart';
import '/models/profile.dart';
import '/models/school.dart';
import '/utils/logger.dart';

class ProfileFormController extends GetxController {
  RxList<String> messageErrors = <String>[].obs;
  Rx<Profile> model = Profile().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  var gender = 'Nam'.obs;
  Rx<DateTime> selectedDate =
      DateTime.now().subtract(const Duration(days: 4 * 365)).obs;
  Rx<School?> selectedSchool = Rx<School?>(null);
  RxList<School> listSchool = <School>[].obs;
  RxList<School> filteredSchools = <School>[].obs;
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  Future getProfileById(String id) async {
    try {
      Profile profile = await ProfileService().getById(id);
      // model.value = await ProfileService().getById(id);
      fullnameController.text = profile.fullName!;
      nickNameController.text = profile.nickName!;
      heightController.text = profile.fullName!;
      selectedDate.value = profile.dob!;
      // weightController.text = profile.fullName!;
      // heightController.text =
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getSchools() async {
    try {
      listSchool.value = await SchoolService().getAll();
      filteredSchools = listSchool;
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
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredSchools.value = listSchool
          .where((school) =>
              school.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredSchools = listSchool;
    }
  }

  void submitForm() {
    messageErrors.value = [];
    model.value.fullName = fullnameController.text;
    model.value.nickName = nickNameController.text;
    model.value.className = classController.text;
    model.value.dob = selectedDate.value;
    model.value.avatarPath = imagePath.value;
    model.value.bmis = [Bmi()];
    model.value.bmis!.last.height = double.parse(heightController.text);
    model.value.bmis!.last.weight = double.parse(weightController.text);
    model.value.bmis!.last.age = DateTime.now().year - model.value.dob!.year;
    model.value.school = School();
    model.value.school!.id = selectedSchool.value!.id!;

    //fake data
    model.value.gender = gender.value == 'Nam' ? true : false;
    //
    if (formKey.currentState!.validate() && imagePath.value.isNotEmpty) {
      try {
        ProfileService().create(model.value);
        Get.back();
      } catch (e) {
        throw Exception(e);
      }
    } else {
      messageErrors.add('Thông tin chưa chính xác');
    }
    if (imagePath.value.isEmpty) messageErrors.add('Ảnh trống');
  }
}
