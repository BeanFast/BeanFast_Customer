import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(TransactionController());
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Tìm kiếm giao dịch',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            // Handle search operation here
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: () {
              showFilterDialog(context);
            },
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                transactionController.isMoneyVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                transactionController.toggleMoneyVisibility();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   color: Colors.grey[300],
            //   height: 40,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SizedBox(
            //         width: 120,
            //         child: Obx(
            //           () => DropdownButtonHideUnderline(
            //             child: DropdownButton<String>(
            //               value: transactionController.dropdownValue.value,
            //               iconSize: 24,
            //               elevation: 16,
            //               icon: const Icon(Icons.arrow_drop_down),
            //               dropdownColor: Colors.white,
            //               style: const TextStyle(
            //                   color: Color(0xFF26AA91), fontSize: 14),
            //               onChanged: (String? newValue) {
            //                 transactionController.updateStatus(newValue!);
            //               },
            //               items: <String>[
            //                 'Hoàn thành 1',
            //                 'Hoàn thành 2',
            //                 'Hoàn thành 3',
            //                 'Hoàn thành 4'
            //               ].map<DropdownMenuItem<String>>((String value) {
            //                 return DropdownMenuItem<String>(
            //                   value: value,
            //                   child: Text(value),
            //                 );
            //               }).toList(),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const VerticalDivider(color: Colors.grey, thickness: 1),
            //       SizedBox(
            //         width: MediaQuery.of(context).size.width - 120 - 40,
            //         child: TextButton(
            //           onPressed: () async {
            //             final DateTimeRange? pickedDateRange =
            //                 await showDateRangePicker(
            //               context: context,
            //               firstDate: DateTime(DateTime.now().year - 5),
            //               lastDate: DateTime.now(),
            //               initialDateRange:
            //                   transactionController.selectedDateRange.value,
            //             );
            //             if (pickedDateRange != null &&
            //                 pickedDateRange !=
            //                     transactionController.selectedDateRange.value) {
            //               transactionController.selectedDateRange.value =
            //                   pickedDateRange;
            //             }
            //           },
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Obx(
            //                 () => Text(
            //                   ' ${DateFormat('dd/MM/yyyy').format(transactionController.selectedDateRange.value.start)}'
            //                   ' - ${DateFormat('dd/MM/yyyy').format(transactionController.selectedDateRange.value.end)}',
            //                   style: const TextStyle(
            //                       color: Color(0xFF26AA91), fontSize: 14),
            //                 ),
            //               ),
            //               const SizedBox(width: 8),
            //               const Icon(Icons.arrow_drop_down),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //tháng 3
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        color: Colors.blue[300],
                        child: const Text('Tháng 3/2024',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
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
                                    height: 95,
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.grey[300],
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: const Icon(
                                                Icons.account_balance_wallet,
                                              )),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    'Nội dung chuyển khoản 1',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Row(
                                                          children: [
                                                            Text('03:11',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14)),
                                                            Text(' - ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14)),
                                                            Text('03/03/2024',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Obx(
                                                          () => SizedBox(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'Số dư ví: ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  transactionController
                                                                      .moneyValue
                                                                      .value,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: 120,
                                                      child: const Text(
                                                          '+200.000.000đ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))),
                  ],
                ),
                //tháng 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        color: Colors.blue[300],
                        child: const Text('Tháng 2/2024',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
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
                                    height: 95,
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.grey[300],
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: const Icon(
                                                Icons.account_balance_wallet,
                                              )),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    'Nội dung chuyển khoản 1',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Row(
                                                          children: [
                                                            Text('03:11',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14)),
                                                            Text(' - ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14)),
                                                            Text('03/03/2024',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Obx(
                                                          () => SizedBox(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'Số dư ví: ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  transactionController
                                                                      .moneyValue
                                                                      .value,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: 120,
                                                      child: const Text(
                                                          '+200.000.000đ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TransactionController extends GetxController {
  // Rx<DateTime> selectedDate = DateTime.now().obs;
  // RxString dropdownValue = 'Hoàn thành 1'.obs;

  // Rx<DateTimeRange> selectedDateRange = Rx<DateTimeRange>(
  //   DateTimeRange(
  //     start: DateTime.now().subtract(const Duration(days: 7)),
  //     end: DateTime.now(),
  //   ),
  // );
  // void updateStatus(String status) {
  //   dropdownValue.value = status;
  // }

  var isMoneyVisible = false.obs;
  RxString moneyValue = '*********'.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value = isMoneyVisible.value ? '70.987.000.000đ' : '*********';
  }

  var selectedSortByMonth = 'Tất cả'.obs;
  var selectedSortByStatus = 'Tất cả'.obs;
}

void showFilterDialog(BuildContext context) {
  final TransactionController controller = Get.find();
  String tempselectedSortByMonth = controller.selectedSortByMonth.value;
  String tempselectedSortByStatus = controller.selectedSortByStatus.value;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Bộ lọc'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theo tháng',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: (1.75 / 1),
                  children: <Widget>[
                    ...['Tất cả', '3/24', '2/24', '1/24', '12/23', '11/23']
                        .map((month) {
                      return Obx(() => GestureDetector(
                            child: Container(
                              height: 10,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: controller.selectedSortByMonth.value ==
                                        month
                                    ? Colors.pink[100]
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 1,
                                ),
                              ),
                              child: Text(month),
                            ),
                            onTap: () {
                              tempselectedSortByMonth = month;
                            },
                          ));
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Theo Trạng thái',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: (3 / 1),
                  children: <Widget>[
                    ...[
                      'Tất cả',
                      'Thành công',
                      'Đang xử lý',
                      'Thất bại',
                    ].map((status) {
                      return Obx(() => GestureDetector(
                            child: Container(
                              height: 10,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: controller.selectedSortByStatus.value ==
                                        status
                                    ? Colors.pink[100]
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 1,
                                ),
                              ),
                              child: Text(status),
                            ),
                            onTap: () {
                              tempselectedSortByStatus = status;
                            },
                          ));
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade200), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Xoá bộ lộc',
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.pink), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.selectedSortByMonth.value =
                          tempselectedSortByMonth;
                      controller.selectedSortByStatus.value =
                          tempselectedSortByStatus;
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('Áp dụng', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
