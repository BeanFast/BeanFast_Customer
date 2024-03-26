import 'package:beanfast_customer/contrains/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateStudentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CreateStudentScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  Obx(
                    () => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ThemeColor.inputColor,
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: createStudentController.dropdownValue.value,
                          iconSize: 24,
                          elevation: 16,
                          icon: const Icon(Icons.arrow_drop_down),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Color(0xFF26AA91), fontSize: 14),
                          onChanged: (String? newValue) {
                            createStudentController.updateStatus(newValue!);
                          },
                          items: <String>[
                            'Trường tiểu học A',
                            'Trường tiểu học B',
                            'Trường tiểu học C',
                            'Trường tiểu học D',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
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
                      onPressed: () {},
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.save),
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
                          // If the form is valid, do something
                        }
                        // Get.back();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save),
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
      DateTime.now().subtract(Duration(days: 4 * 365)).obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  RxString dropdownValue = 'Trường tiểu học A'.obs;

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
  );
  void updateStatus(String status) {
    dropdownValue.value = status;
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
