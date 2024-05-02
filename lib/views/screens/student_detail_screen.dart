import 'package:beanfast_customer/views/screens/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../widgets/image_default.dart';
import '/controllers/auth_controller.dart';
import '/models/profile.dart';
import '/utils/constants.dart';
import '/views/screens/loading_screen.dart';
import '/views//widgets/row_info_item_widget.dart';
import 'student_form_screen.dart';

class StudentDetailScreen extends GetView<AuthController> {
  const StudentDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileController());
    Rx<Profile> model = Profile().obs;
    return LoadingScreen(
      future: () async {
        await controller.getCurrentUser();
        model.value =
            currentUser.value!.profiles!.firstWhere((e) => e.id == id);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin học sinh'),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_2),
            onPressed: () {
              Get.off(const StudentListScreen());
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CustomNetworkImage(
                        model.value.avatarPath.toString(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      model.value.fullName.toString(),
                      style: Get.textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      model.value.nickName.toString(),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Get.to(StudentFormScreen(profileId: model.value.id));
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
                              data: model.value.fullName.toString()),
                          RowInfoItemWidget(
                              title: 'Biệt danh: ',
                              data: model.value.nickName.toString()),
                          RowInfoItemWidget(
                              title: 'Giới tính: ',
                              data: model.value.gender! ? 'Nam' : 'Nữ'),
                          RowInfoItemWidget(
                              title: 'Ngày sinh: ',
                              data: DateFormat('dd/MM/yyyy')
                                  .format(model.value.dob!)),
                          RowInfoItemWidget(
                              title: 'BMI: ',
                              data: model.value.currentBMI.toString()),
                          RowInfoItemWidget(
                              title: 'Lớp: ',
                              data: model.value.className.toString()),
                          RowInfoItemWidget(
                              title: 'Trường: ',
                              data: model.value.school!.name.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
