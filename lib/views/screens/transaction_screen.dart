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
        toolbarHeight: 80,
        title: Container(
          alignment: Alignment.center,
          height: 50,
          child: TextField(
            style: const TextStyle(height: 1), // Adjust the height as needed
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 10),
              hintText: 'Tìm kiếm giao dịch',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(100), // Set the border radius to 10
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              // Handle search operation here
            },
          ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //tháng 3
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                alignment: Alignment.centerLeft,
                color: Colors.blue[300],
                child: const Text('Tháng 3/2024',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
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
                    color: index % 2 == 0 ? Colors.white : Colors.grey[300],
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey)),
                            child: const Icon(
                              Icons.account_balance_wallet,
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Nội dung chuyển khoản 1',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('03:11 - 03/03/2024',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14)),
                                      const SizedBox(height: 5),
                                      Obx(
                                        () => SizedBox(
                                          child: Text(
                                            'Số dư ví: ${transactionController.moneyValue.value}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    width: 120,
                                    child: const Text('+200.000.000đ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionController extends GetxController {
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
