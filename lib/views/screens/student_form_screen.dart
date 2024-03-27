import 'dart:io';

import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/profile_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentFormScreen extends GetView<ProfileFormController> {
  const StudentFormScreen({super.key, required this.isUpdate});
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileFormController());
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
                  Obx(
                    () => controller.imagePath.value.isNotEmpty
                        ? ClipOval(
                            child: Image.file(
                              File(controller.imagePath.value),
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
                                      controller.pickPhotoFormCamera();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                        Icons.photo_library_outlined),
                                    title:
                                        const Text('Chọn ảnh từ thư viện ảnh'),
                                    onTap: () async {
                                      controller.pickPhotoFormStorage();
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 85,
                    child: TextFormField(
                      controller: controller.fullnameController,
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
                      controller: controller.nickNameController,
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
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value as String;
                          },
                        ),
                      ),
                      const Text('Nam'),
                      Obx(
                        () => Radio(
                          value: 'Nữ',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value as String;
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
                                picked != controller.selectedDate.value) {
                              controller.updateDate(picked);
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Ngày sinh: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}",
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
                          controller: controller.heightController,
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
                          controller: controller.weightController,
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
                                          controller
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
                                          itemCount:
                                              controller.filteredSchools.length,
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
                                                    controller
                                                        .filteredSchools[index]
                                                        .imagePath!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                title: Text(controller
                                                    .filteredSchools[index]
                                                    .name!),
                                                subtitle: Text(controller
                                                    .filteredSchools[index]
                                                    .address!),
                                                onTap: () {
                                                  // Update the selected school
                                                  controller.selectedSchool
                                                          .value =
                                                      controller
                                                          .filteredSchools[
                                                              index]
                                                          .name!;
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
                              controller.selectedSchool.value.isEmpty
                                  ? 'Chọn trường học'
                                  : controller.selectedSchool.value,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // controller.messageErrors.map((e) => SizedBox(height: 64, child: Text(e.toString()))
                  // ).toList(),
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
                        if (controller.formKey.currentState!.validate()) {
                          if (controller.selectedSchool.value.isEmpty) {
                            Get.snackbar('Lỗi', 'Vui lòng chọn trường');
                          } else {
                            controller.submitForm();
                          }
                        }
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

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
