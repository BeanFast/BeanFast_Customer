import 'package:beanfast_customer/controllers/home_controller.dart';
import 'package:beanfast_customer/controllers/transaction_controller.dart';
import 'package:beanfast_customer/utils/formater.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends GetView<TransactionController> {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    Get.put(TransactionController());
    return LoadingScreen(
      future: controller.getTransaction,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            height: 40,
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
                prefixIcon: const Icon(
                  Iconsax.search_normal,
                  size: 20,
                ),
              ),
              onChanged: (value) {
                // Handle search operation here
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Iconsax.filter_search),
              onPressed: () {
                showFilterDialog(context);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Màu của đổ bóng và độ mờ
                    spreadRadius: 5, // Độ lan rộng của đổ bóng
                    blurRadius: 7, // Độ mờ của đổ bóng
                    offset: const Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              height: 50,
              child: Obx(
                () => Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        homeController.isMoneyVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 16,
                      ),
                      onPressed: () {
                        homeController.toggleMoneyVisibility();
                      },
                    ),
                    Text(
                      homeController.moneyValue.value,
                      style: Get.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: controller.mapTransactions.entries
                        .map(
                          (transaction) => Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: 50,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromARGB(255, 198, 229, 245),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 198, 229, 245),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Tháng ${transaction.key}',
                                  style: Get.textTheme.titleMedium,
                                ),
                              ),
                              Column(
                                children: transaction.value.map((element) {
                                  var transactionType =
                                      element.order!.code == null
                                          ? "Nạp tiền"
                                          : "Thanh toán";
                                  IconData iconData =
                                      element.order!.code == null
                                          ? Iconsax.wallet_add_1
                                          : Iconsax.wallet_minus;
                                  var color = element.value! > 0
                                      ? Colors.green
                                      : Colors.red;
                                  return Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Icon(
                                              iconData,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  element.order!.code != null
                                                      ? "$transactionType: #${element.order!.code!}"
                                                      : transactionType,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Get
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            formatter.format(
                                                                element.time!),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Get.textTheme
                                                                .bodySmall,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: 120,
                                                      child: Text(
                                                        element.value! > 0
                                                            ? "+${Formater.formatMoney(element.value.toString())}"
                                                            : Formater.formatMoney(
                                                                element.value
                                                                    .toString()),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Get.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color: color,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        )
                        .toList(),
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
                      print(tempselectedSortByMonth.value);
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
