import 'dart:io';

import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class StudentFormScreen extends GetView<ProfileController> {
   StudentFormScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  final String check = '2';
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final CreateStudentController createStudentController =
        Get.put(CreateStudentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin học sinh',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(() => SizedBox(
                        width: 100,
                        height: 100,
                        child: controller.imagePath.isEmpty
                            ? const Text('No image selected')
                            : Image.network(
                                controller.imagePath.value,
                                fit: BoxFit.cover,
                              ),
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 85,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Họ và tên',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 85,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Biệt danh',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập biệt danh';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Radio(
                          value: 'Nam',
                          groupValue: createStudentController.gender.value,
                          onChanged: (value) {
                            createStudentController.gender.value =
                                value as String;
                          },
                        ),
                      ),
                      const Text('Nam'),
                      Obx(
                        () => Radio(
                          value: 'Nữ',
                          groupValue: createStudentController.gender.value,
                          onChanged: (value) {
                            createStudentController.gender.value =
                                value as String;
                          },
                        ),
                      ),
                      const Text('Nữ'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 65,
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                HexColor("#26AA91")), // Text color
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white), // Background color
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(10)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    const BorderSide(color: Color(0xFF26AA91)),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              locale: const Locale("vi", "VI"),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                                  .subtract(const Duration(days: 4 * 365)),
                            );
                            if (picked != null &&
                                picked !=
                                    createStudentController
                                        .selectedDate.value) {
                              createStudentController.updateDate(picked);
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Ngày sinh: ${DateFormat('dd/MM/yyyy').format(createStudentController.selectedDate.value)}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 85,
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Chiều cao (m)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Không hợp lệ';
                            }
                            if (!isNumeric(value)) {
                              return 'Không hợp lệ';
                            }
                            if (double.parse(value) < 0.5 ||
                                double.parse(value) > 3.0) {
                              return 'Không hợp lệ';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        height: 85,
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Cân nặng (kg)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Không hợp lệ';
                            }
                            if (!isNumeric(value)) {
                              return 'Không hợp lệ';
                            }
                            if (double.parse(value) < 1.0 ||
                                double.parse(value) > 500.0) {
                              return 'Không hợp lệ';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 65,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              HexColor("#26AA91")), // Text color
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Background color
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(10)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Color(0xFF26AA91)),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  right: 10,
                                  left: 10,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 65,
                                          child: Center(
                                            child: Text(
                                              "Chọn trường học",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Icon(
                                            Icons.close_outlined,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 60,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: TextField(
                                        onChanged: (value) {
                                          createStudentController
                                              .updateFilteredSchools(value);
                                        },
                                        decoration: const InputDecoration(
                                          labelText: "Tìm kiếm theo tên trường",
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Expanded(
                                        child: ListView.builder(
                                          itemCount: createStudentController
                                              .filteredSchools.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5,
                                                  ),
                                                ),
                                              ),
                                              child: ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: Image.network(
                                                    createStudentController
                                                        .filteredSchools[index]
                                                        .image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                title: Text(
                                                    createStudentController
                                                        .filteredSchools[index]
                                                        .name),
                                                subtitle: Text(
                                                    createStudentController
                                                        .filteredSchools[index]
                                                        .shortDescription),
                                                onTap: () {
                                                  // Update the selected school
                                                  createStudentController
                                                          .selectedSchool
                                                          .value =
                                                      createStudentController
                                                          .filteredSchools[
                                                              index]
                                                          .name;
                                                  // Close the bottom sheet
                                                  Get.back();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Obx(
                            () => Text(
                              createStudentController
                                      .selectedSchool.value.isEmpty
                                  ? 'Chọn trường học'
                                  : createStudentController
                                      .selectedSchool.value,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => createStudentController.imagePath.value.isNotEmpty
                        ? ClipOval(
                            child: Image.file(
                              File(createStudentController.imagePath.value),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(), // Show an empty container when no image is selected
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 55,
                    width: 100,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green), // Background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // controller.pickImage();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                right: 10,
                                left: 10,
                              ),
                              child: Wrap(
                                children: <Widget>[
                                  const SizedBox(
                                    child: Center(
                                      child: Text(
                                        "Lựa chọn phương thức",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_outlined),
                                    title: const Text('Chụp ảnh'),
                                    onTap: () async {
                                      // Logic for taking a picture
                                      var status =
                                          await Permission.camera.status;
                                      if (!status.isGranted) {
                                        status =
                                            await Permission.camera.request();
                                      }

                                      final XFile? image =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);

                                      if (image != null) {
                                        createStudentController
                                            .imagePath.value = image.path;
                                        Get.back();
                                      } else {
                                        // User canceled the picker
                                        print('No picture taken.');
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                        Icons.photo_library_outlined),
                                    title:
                                        const Text('Chọn ảnh từ thư viện ảnh'),
                                    onTap: () async {
                                      // await Permission.photos.request();
                                      var status =
                                          await Permission.photos.status;
                                      if (!status.isGranted) {
                                        status =
                                            await Permission.photos.request();
                                      }

                                      if (status.isGranted) {
                                        final XFile? image =
                                            await _picker.pickImage(
                                                source: ImageSource.gallery);

                                        if (image != null) {
                                          // Use the selected image
                                          createStudentController
                                              .imagePath.value = image.path;

                                          Get.back();
                                        } else {
                                          // User canceled the picker
                                          Get.snackbar('Thông báo',
                                              'No image selected.');
                                        }
                                      } else {
                                        Get.snackbar(
                                            'Thông báo', 'Permission denied.');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.save_outlined),
                          Text('Tải ảnh', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 64,
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green), // Background color
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (createStudentController
                              .selectedSchool.value.isEmpty) {
                            Get.snackbar('Lỗi', 'Vui lòng chọn trường');
                          } else {
                            //true
                          }
                        }
                        Get.back();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save_outlined),
                          SizedBox(width: 10),
                          Text('Lưu', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class CreateStudentController extends GetxController {
  Rx<DateTime> selectedDate =
      DateTime.now().subtract(const Duration(days: 4 * 365)).obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
  );

  //bottom sheet
  var selectedSchool = ''.obs;
  var schools = <School>[].obs;
  RxList<School> filteredSchools = <School>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add your initial list of schools here
    schools.addAll([
      School(
          name: 'School 1',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          shortDescription: 'This is school 1'),
      School(
          name: 'School 2',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          shortDescription: 'This is school 2'),
      School(
          name: 'School 3',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          shortDescription: 'This is school 3'),
      School(
          name: 'School 4',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          shortDescription: 'This is school 4'),
      School(
          name: 'School 5',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTgMLFHseMBhcKd12N6gXsGljxQcBvtJ_qKHf_ytWKdQ&s',
          shortDescription: 'This is school 5'),
    ]);
    updateFilteredSchools();
  }

  void updateFilteredSchools([String? searchQuery]) {
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredSchools.value = schools
          .where((school) =>
              school.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredSchools.value = schools.toList();
    }
  }

  //Update image
  var imagePath = ''.obs;
  //gender
  var gender = 'Nam'.obs;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class School {
  final String name;
  final String image;
  final String shortDescription;

  School({
    required this.name,
    required this.image,
    required this.shortDescription,
  });
}
