import 'package:beanfast_customer/controllers/profile_controller.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/row_info_item_widget.dart';
import 'student_form_screen.dart';

class StudentDetailScreen extends GetView<ProfileController> {
  const StudentDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return LoadingScreen(
      future: () async {
        return await controller.getById(id);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin học sinh'),
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
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.model.value.avatarPath.toString(),
                        ),
                        radius: 15,
                      ),
                    ),
                    title: Text(
                      controller.model.value.fullName.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      controller.model.value.nickName.toString(),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Get.to(const StudentFormScreen(isUpdate: true));
                      },
                      child: const Text(
                        'Thay đổi',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Thẻ nhận hàng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.model.value.loyaltyCards!.map((e) {
                          return Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 300,
                            height: 170,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: Get.width,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          e.backgroundImagePath!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    alignment: Alignment.center,
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: const Text('Đang dùng'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Thông tin học sinh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
                              data: controller.model.value.fullName.toString()),
                          RowInfoItemWidget(
                              title: 'Biệt danh: ',
                              data: controller.model.value.nickName.toString()),
                          RowInfoItemWidget(
                              title: 'Giới tính: ',
                              data: controller.model.value.gender!
                                  ? 'Nam'
                                  : 'Nữ'),
                          RowInfoItemWidget(
                              title: 'Ngày sinh: ',
                              data: DateFormat('dd/MM/yyyy')
                                  .format(controller.model.value.dob!)),
                          RowInfoItemWidget(
                              title: 'BMI: ',
                              data:
                                  controller.model.value.currentBMI.toString()),
                          RowInfoItemWidget(
                              title: 'Lớp: ',
                              data:
                                  controller.model.value.className.toString()),
                          RowInfoItemWidget(
                              title: 'Trường: ',
                              data: controller.model.value.school!.name
                                  .toString()),
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
