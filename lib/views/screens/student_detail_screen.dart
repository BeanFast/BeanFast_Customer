import 'package:beanfast_customer/views/screens/add_new_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin học sinh'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr0A_VRvBAuUbJRjVZBMBBmm5YTLN0RUr_WFlJ_wwxEA&s',
                    ),
                    radius: 15,
                  ),
                ),
                title: const Text(
                  'Nguyễn Huỳnh Phi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'PhiPhiPh1',
                ),
                trailing: TextButton(
                  onPressed: () {
                    Get.to(CreateStudentScreen());
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
                    children: List.generate(
                      5,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 300,
                        height: 170,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr0A_VRvBAuUbJRjVZBMBBmm5YTLN0RUr_WFlJ_wwxEA&s',
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
                      ),
                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'Biệt danh: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              'Trường tiểu học nguyễn văn ABCDEF',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'Tên: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              'Nguyễn Huỳnh Phi',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'Giới tính: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              'Nam',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'Ngày sinh: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              '15/06/2001',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'BMI: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              '29.5',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'Trường: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              'Trường tiểu học nguyễn văn ABCDEFGHJKLMN',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Text(
                            'Lớp: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )),
                          const Expanded(
                            child: Text(
                              'Trường tiểu học nguyễn văn A',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
