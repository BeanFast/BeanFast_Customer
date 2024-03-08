import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(TransactionController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch', style: TextStyle(fontSize: 30)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Handle the icon tap here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png'), // Replace with your asset path
                          radius: 30,
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nguyễn Huỳnh Phi'),
                            Text('0966324244'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1),
                Obx(
                  () => Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              transactionController.isMoneyVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              transactionController.toggleMoneyVisibility();
                            },
                          ),
                          Text(
                            transactionController.moneyValue.value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              color: Colors.grey[300],
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: transactionController.dropdownValue.value,
                          iconSize: 24,
                          elevation: 16,
                          icon: const Icon(Icons.arrow_drop_down),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Color(0xFF26AA91), fontSize: 14),
                          onChanged: (String? newValue) {
                            transactionController.updateStatus(newValue!);
                          },
                          items: <String>[
                            'Hoàn thành 1',
                            'Hoàn thành 2',
                            'Hoàn thành 3',
                            'Hoàn thành 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120 - 40,
                    child: TextButton(
                      onPressed: () async {
                        final DateTimeRange? pickedDateRange =
                            await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime.now(),
                          initialDateRange:
                              transactionController.selectedDateRange.value,
                        );

                        if (pickedDateRange != null &&
                            pickedDateRange !=
                                transactionController.selectedDateRange.value) {
                          transactionController.selectedDateRange.value =
                              pickedDateRange;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => Text(
                              ' ${DateFormat('dd/MM/yyyy').format(transactionController.selectedDateRange.value.start)}'
                              ' - ${DateFormat('dd/MM/yyyy').format(transactionController.selectedDateRange.value.end)}',
                              style: const TextStyle(
                                  color: Color(0xFF26AA91), fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Thứ 6, 8/3/2024'),
                  const SizedBox(height: 10),
                  Column(
                      children: List.generate(
                          4,
                          (index) => GestureDetector(
                                onTap: () {
                                  Get.snackbar(
                                    'Giao dịch',
                                    index.toString(),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: Colors.grey[300],
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('8/3/2024',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text('#123456789',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Số tiền',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text('-500.000 đ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Số dư',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text('1.500.000 đ',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                  const SizedBox(height: 10),
                  const Text('Thứ 5, 7/3/2024'),
                  const SizedBox(height: 10),
                  Column(
                      children: List.generate(
                          4,
                          (index) => GestureDetector(
                                onTap: () {
                                  Get.snackbar(
                                    'Giao dịch',
                                    index.toString(),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: Colors.grey[300],
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('8/3/2024',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text('#123456789',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Số tiền',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text('+500.000 đ',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Số dư',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text('1.500.000 đ',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString dropdownValue = 'Hoàn thành 1'.obs;

  Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
  );
  void updateStatus(String status) {
    dropdownValue.value = status;
  }

  var isMoneyVisible = false.obs;
  RxString moneyValue = '********* đ'.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value =
        isMoneyVisible.value ? '70.967.000.000 đ' : '********* đ';
  }
}
