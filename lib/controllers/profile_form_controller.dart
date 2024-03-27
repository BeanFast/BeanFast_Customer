import 'package:beanfast_customer/models/bmi.dart';
import 'package:beanfast_customer/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var selectedSchool = ''.obs;
  var schools = <School>[].obs;
  RxList<School> filteredSchools = <School>[].obs;
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  // final TextEditingController nickNameController = TextEditingController();

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

  @override
  void onInit() {
    super.onInit();
    // Add your initial list of schools here
    schools.addAll([
      School(
          name: 'School 1',
          imagePath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          address: 'This is school 1'),
      School(
          name: 'School 2',
          imagePath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          address: 'This is school 2'),
      School(
          name: 'School 3',
          imagePath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          address: 'This is school 3'),
      School(
          name: 'School 4',
          imagePath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          address: 'This is school 4'),
      School(
          name: 'School 5',
          imagePath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          address: 'This is school 5'),
    ]);
    updateFilteredSchools();
  }

  void updateFilteredSchools([String? searchQuery]) {
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredSchools.value = schools
          .where((school) =>
              school.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredSchools.value = schools.toList();
    }
  }

  void submitForm() {
    messageErrors.value = [];
    model.value.fullName = fullnameController.text;
    model.value.nickName = nickNameController.text;
    model.value.dob = selectedDate.value;
    model.value.bmis = [Bmi()];
    model.value.bmis!.last.height = double.parse(heightController.text);
    model.value.bmis!.last.weight = double.parse(weightController.text);
    model.value.bmis!.last.age = DateTime.now().year - model.value.dob!.year;
    model.value.avatarPath = imagePath.value;

    //fake data
    model.value.gender = true;
    model.value.className = '1A1';
    model.value.school = School();
    model.value.school!.id = '86BF8338-F36D-48DA-A284-236379AE9CBF';
    //
    if (formKey.currentState!.validate() && imagePath.value.isNotEmpty) {
      try {
        ProfileService().create(model.value);
        Get.back();
      } catch (e) {
        throw Exception(e);
      }
    }else{
      messageErrors.add('Thông tin chưa chính xác');
    }
    if (imagePath.value.isEmpty) messageErrors.add('Ảnh trống');
  }
}
