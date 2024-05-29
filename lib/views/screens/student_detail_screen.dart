import 'package:beanfast_customer/contains/theme_color.dart';
import 'package:beanfast_customer/views/widgets/sbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/profile_controller.dart';
import '/views/screens/data_screen.dart';
import '/views/widgets/image_default.dart';
import '/views/screens/loading_screen.dart';
import '/views//widgets/row_info_item_widget.dart';
import 'student_form_screen.dart';

class StudentDetailScreen extends GetView<ProfileController> {
  const StudentDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin học sinh'),
      ),
      body: LoadingScreen(
        future: () => controller.getById(id),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => DataScreen(
                hasData: controller.model.value != null,
                message: 'Chưa có dữ liệu',
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CustomNetworkImage(
                            controller.model.value!.avatarPath.toString(),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          controller.model.value!.fullName.toString(),
                          style: Get.textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          controller.model.value!.nickName.toString(),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            Get.to(() => StudentFormScreen(
                                profileId: controller.model.value!.id));
                          },
                          child: const Text(
                            'Thay đổi',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Thông tin học sinh',
                        style: Get.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 30,
                            bottom: 30,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RowInfoItemWidget(
                                  title: 'Tên: ',
                                  data: controller.model.value!.fullName
                                      .toString()),
                              RowInfoItemWidget(
                                  title: 'Biệt danh: ',
                                  data: controller.model.value!.nickName
                                      .toString()),
                              RowInfoItemWidget(
                                  title: 'Giới tính: ',
                                  data: controller.model.value!.gender!
                                      ? 'Nam'
                                      : 'Nữ'),
                              RowInfoItemWidget(
                                  title: 'Ngày sinh: ',
                                  data: DateFormat('dd/MM/yyyy')
                                      .format(controller.model.value!.dob!)),
                              RowInfoItemWidget(
                                  title: 'BMI: ',
                                  data: controller.model.value!.currentBMI
                                      .toString()),
                              RowInfoItemWidget(
                                  title: 'Lớp: ',
                                  data: controller.model.value!.className
                                      .toString()),
                              RowInfoItemWidget(
                                  title: 'Trường: ',
                                  data: controller.model.value!.school!.name
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SButton(
                            color: ThemeColor.itemColor,
                            borderColor: ThemeColor.textButtonColor,
                            text: 'Xoá học sinh',
                            textStyle: Get.textTheme.bodyMedium!.copyWith(
                              color: ThemeColor.textButtonColor,
                            ),
                            onPressed: () {
                              showDeleteChildDialog();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showDeleteChildDialog() {
  Get.dialog(
    AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: ThemeColor.itemColor,
      title: const Text('Xác nhận'),
      content: SizedBox(
        height: 40,
        child: Text(
          'Bạn có chắc chắn muốn xoá học sinh này không?',
          style: Get.textTheme.bodyLarge,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            // controller.deleteChild(id);
          },
          child: Text('Xoá',
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Đóng',
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.grey)),
        ),
      ],
    ),
  );
}
