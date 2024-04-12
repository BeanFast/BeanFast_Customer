import 'package:beanfast_customer/models/transaction.dart';
import 'package:beanfast_customer/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  RxList<Transaction> transactions = <Transaction>[].obs;
  List<String> listMonth = [
    'Tất cả',
    '3/24',
    '2/24',
    '1/24',
    '12/23',
    '11/23',
    '10/23'
  ];
  List<String> listStatus = ['Tất cả', 'Thành công', 'Đang xử lý', 'Thất bại'];

  var isMoneyVisible = false.obs;
  RxString moneyValue = '*********'.obs;

  void toggleMoneyVisibility() {
    isMoneyVisible.value = !isMoneyVisible.value;
    moneyValue.value = isMoneyVisible.value ? '70.987.000.000đ' : '*********';
  }

  Future getTransaction() async {
    try {
      transactions.value = await TransactionService().getTransactions(
          1, 100, "money", "7B9C01DB-0D49-403D-ADC0-6CFB9CEF6D3A");
    } catch (e) {
   
      throw Exception(e);
    }
  }

  int indexSelectedSortByMonth = 0;
  int indexSelectedSortByStatus = 0;
}

void showFilterDialog(BuildContext context) {
  final TransactionController controller = Get.find();
  Rx<int> tempselectedSortByMonth = controller.indexSelectedSortByMonth.obs;
  Rx<int> tempselectedSortByStatus = controller.indexSelectedSortByStatus.obs;
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
                  children: controller.listMonth.map((month) {
                    return Obx(() => GestureDetector(
                          child: Container(
                            height: 10,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tempselectedSortByMonth.value ==
                                      controller.listMonth.indexOf(month)
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
                            tempselectedSortByMonth.value =
                                controller.listMonth.indexOf(month);
                          },
                        ));
                  }).toList(),
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
                  children: controller.listStatus.map((status) {
                    return Obx(() => GestureDetector(
                          child: Container(
                            height: 10,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tempselectedSortByStatus.value ==
                                      controller.listStatus.indexOf(status)
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
                            tempselectedSortByStatus.value =
                                controller.listStatus.indexOf(status);
                          },
                        ));
                  }).toList(),
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
                  child: Obx(() => ElevatedButton(
                        style: tempselectedSortByStatus.value != 0 ||
                                tempselectedSortByMonth.value != 0
                            ? ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white), // Text color
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.pink), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(5)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              )
                            : ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey), // Text color
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors
                                        .grey.shade200), // Background color
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(5)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                        onPressed: () {
                          tempselectedSortByMonth.value = 0;
                          tempselectedSortByStatus.value = 0;
                        },
                        child: const Text('Xoá bộ lọc',
                            style: TextStyle(fontSize: 16)),
                      )),
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
                      controller.indexSelectedSortByMonth =
                          tempselectedSortByMonth.value;
               
                      controller.indexSelectedSortByStatus =
                          tempselectedSortByStatus.value;
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
