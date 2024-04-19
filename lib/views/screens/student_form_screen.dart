import 'dart:io';

import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:beanfast_customer/controllers/profile_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        height: 50,
                        width: 100,
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                ThemeColor.textButtonColor), // Text color
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColor.itemColor), // Background color
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(10)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: ThemeColor.textButtonColor),
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
                                      SizedBox(
                                        child: Center(
                                          child: Text(
                                            "Lựa chọn phương thức",
                                            style: Get.textTheme.titleLarge,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(Iconsax.camera),
                                        title: const Text('Chụp ảnh'),
                                        onTap: () async {
                                          controller.pickPhotoFormCamera();
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Iconsax.gallery_add),
                                        title: const Text(
                                            'Chọn ảnh từ thư viện ảnh'),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Iconsax.document_copy),
                              Text(
                                'Tải ảnh',
                                style: Get.textTheme.titleSmall!.copyWith(
                                  color: ThemeColor.textButtonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Họ và tên',
                            style: Get.textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: controller.fullnameController,
                              style: Get.textTheme.bodyLarge!.copyWith(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập họ và tên';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 75,
                        child: TextFormField(
                          controller: controller.nickNameController,
                          decoration: const InputDecoration(
                            labelText: 'Biệt danh',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập biệt danh';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return GestureDetector(
                          onTap: () async {
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
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ngày sinh:',
                                  style: Get.textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  " ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}",
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.black),
                              ],
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
                            height: 75,
                            child: TextFormField(
                              controller: controller.heightController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                labelText: 'Chiều cao (m)',
                                border: UnderlineInputBorder(),
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
                            height: 75,
                            child: TextFormField(
                              controller: controller.weightController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                labelText: 'Cân nặng (kg)',
                                border: UnderlineInputBorder(),
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
                      SizedBox(
                        height: 65,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
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
                                          SizedBox(
                                            height: 75,
                                            child: Center(
                                              child: Text(
                                                "Chọn trường học",
                                                style:
                                                    Get.textTheme.titleMedium,
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
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextField(
                                          onChanged: (value) {
                                            controller
                                                .updateFilteredSchools(value);
                                          },
                                          decoration: const InputDecoration(
                                            labelText:
                                                "Tìm kiếm theo tên trường",
                                            prefixIcon: Icon(Icons.search),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Expanded(
                                          child: ListView.builder(
                                            itemCount: controller
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
                                                      controller
                                                          .filteredSchools[
                                                              index]
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
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trường học',
                                  style: Get.textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  controller.selectedSchool.value.isEmpty
                                      ? 'Chọn trường học'
                                      : controller.selectedSchool.value,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Get.width / 1.2,
                  height: 45,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ThemeColor.textButtonColor), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColor.itemColor), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: ThemeColor.textButtonColor),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.document_copy),
                        const SizedBox(width: 10),
                        Text(
                          'Lưu Thông tin',
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: ThemeColor.textButtonColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}
