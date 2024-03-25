import 'package:beanfast_customer/views/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách học sinh'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                child: Column(
                  children: List.generate(
                    10,
                    (index) => GestureDetector(
                      onTap: () {
                        Get.to(const StudentDetailScreen());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          //  color: index % 2 == 0 ? Colors.white : Colors.grey[300],
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text(
                            'Nguyễn Huỳnh Phi',
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: const Text('Trường tiểu học'),
                          trailing: IconButton(
                            onPressed: () {
                              Get.snackbar('title', '222',
                                  snackPosition: SnackPosition.TOP);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Màu của đổ bóng và độ mờ
                  spreadRadius: 5, // Độ lan rộng của đổ bóng
                  blurRadius: 7, // Độ mờ của đổ bóng
                  offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                ),
              ],
            ),

            // padding: const EdgeInsets.only(right: 10, left: 10),
            child: SizedBox(
              child: TextButton(
                style: ButtonStyle(
                  // foregroundColor: MaterialStateProperty.all<Color>(
                  //     Colors.white), // Text color
                  // backgroundColor: MaterialStateProperty.all<Color>(
                  //     Colors.green), // Background color
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      // side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text('Thêm học sinh', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
