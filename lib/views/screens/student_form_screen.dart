import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/views/screens/loading_screen.dart';
import '/contrains/theme_color.dart';
import '/controllers/profile_form_controller.dart';
import '/views/widgets/gradient_button.dart';

class StudentFormScreen extends GetView<ProfileFormController> {
  const StudentFormScreen({super.key, this.profileId});
  final String? profileId;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileFormController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin học sinh',
        ),
      ),
      body: LoadingScreen(
        future: () async {
          if (profileId != null) {
            await controller.getProfileById(profileId!);
          }
          await controller.getSchools();
        },
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Obx(
                              () => Stack(
                                children: [
                                  controller.imagePath.value.isNotEmpty
                                      ? ClipOval(
                                          child: Image.file(
                                            File(controller.imagePath.value),
                                            width: 110,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: const Icon(
                                            Iconsax.user,
                                            size: 50,
                                          ),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
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
                                                        style: Get.textTheme
                                                            .titleLarge,
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Iconsax.camera),
                                                    title:
                                                        const Text('Chụp ảnh'),
                                                    onTap: () async {
                                                      controller
                                                          .pickPhotoFormCamera();
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Iconsax.gallery_add),
                                                    title: const Text(
                                                        'Chọn ảnh từ thư viện ảnh'),
                                                    onTap: () async {
                                                      controller
                                                          .pickPhotoFormStorage();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: ThemeColor.itemColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: ThemeColor.iconColor,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Họ và tên',
                            style: Get.textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            child: TextFormField(
                              controller: controller.fullnameController,
                              style: Get.textTheme.bodyLarge!.copyWith(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập họ và tên';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Biệt danh',
                            style: Get.textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            child: TextFormField(
                              controller: controller.nickNameController,
                              decoration: const InputDecoration(
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
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 25,
                            child: Row(
                              children: [
                                Text(
                                  'Giới tính:',
                                  style: Get.textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Obx(
                                  () => Radio(
                                    value: 'Nam',
                                    groupValue: controller.gender.value,
                                    onChanged: (value) {
                                      controller.gender.value = value as String;
                                    },
                                  ),
                                ),
                                Text('Nam', style: Get.textTheme.bodyLarge),
                                Obx(
                                  () => Radio(
                                    value: 'Nữ',
                                    groupValue: controller.gender.value,
                                    onChanged: (value) {
                                      controller.gender.value = value as String;
                                    },
                                  ),
                                ),
                                Text('Nữ', style: Get.textTheme.bodyLarge),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Obx(() {
                            return GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  locale: const Locale("vi", "VI"),
                                  firstDate: DateTime(1924),
                                  lastDate: DateTime.now()
                                      .subtract(const Duration(days: 5 * 365)),
                                );
                                if (picked != null &&
                                    picked != controller.selectedDate.value) {
                                  controller.updateDate(picked);
                                }
                              },
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ngày sinh:',
                                      style:
                                          Get.textTheme.titleMedium!.copyWith(
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      " ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}",
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Chiều cao (m)',
                                    style: Get.textTheme.titleMedium!.copyWith(
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: Get.width / 2.5,
                                    child: TextFormField(
                                      controller: controller.heightController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: const InputDecoration(
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
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cân nặng (kg)',
                                    style: Get.textTheme.titleMedium!.copyWith(
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: Get.width / 2.5,
                                    child: TextFormField(
                                      controller: controller.weightController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
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
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
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
                                                    style: Get
                                                        .textTheme.titleMedium,
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
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: TextField(
                                              onChanged: (value) {
                                                controller
                                                    .updateFilteredSchools(
                                                        value);
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
                                                    decoration:
                                                        const BoxDecoration(
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
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
                                                          .filteredSchools[
                                                              index]
                                                          .name!),
                                                      subtitle: Text(controller
                                                          .filteredSchools[
                                                              index]
                                                          .address!),
                                                      onTap: () {
                                                        // Update the selected school
                                                        controller
                                                            .selectedSchool
                                                            .value = controller
                                                                .filteredSchools[
                                                            index];
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
                                      style:
                                          Get.textTheme.titleMedium!.copyWith(
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      controller.selectedSchool.value == null
                                          ? 'Chọn trường học'
                                          : controller
                                              .selectedSchool.value!.name
                                              .toString(),
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
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
                            height: 20,
                          ),
                          Text(
                            'Lớp học',
                            style: Get.textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            child: TextFormField(
                              controller: controller.classController,
                              style: Get.textTheme.bodyLarge!.copyWith(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập lớp học';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GradientButton(
                text: 'Lưu Thông tin',
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    if (controller.selectedSchool.value == null) {
                      Get.snackbar('Lỗi', 'Vui lòng chọn trường');
                    } else {
                      await controller.submitForm();
                    }
                  }
                },
              )
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
