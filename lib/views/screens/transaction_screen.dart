import 'package:beanfast_customer/controllers/transaction_controller.dart';
import 'package:beanfast_customer/utils/formater.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(TransactionController());
    return LoadingScreen(
      future: transactionController.getTransaction,
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 198, 229, 245),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  'Tháng 3/2024',
                  style: Get.textTheme.titleMedium,
                ),
              ),
              Obx(
                () => Column(
                  children: transactionController.transactions.map((element) {
                    var index = -1;
                    index++;
                    var transactionType = element.order!.code == null
                        ? "Nạp tiền"
                        : "Thanh toán đơn hàng";
                    IconData iconData = element.order!.code == null
                        ? Iconsax.wallet_add_1
                        : Iconsax.wallet_minus;
                    var color = element.value! > 0 ? Colors.green : Colors.red;
                    return Container(
                      height: 95,
                      color: index % 2 == 0
                          ? Colors.white
                          : const Color.fromARGB(255, 198, 225, 244)
                              .withOpacity(0.3),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Icon(
                              iconData,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  element.order!.code != null
                                      ? "$transactionType: #" +
                                          element.order!.code!
                                      : "$transactionType",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element.time.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.bodySmall,
                                          ),
                                          const SizedBox(height: 5),
                                          // Obx(
                                          //   () => SizedBox(
                                          //     child: Text(
                                          //       'Số dư ví: ${transactionController.moneyValue.value}',
                                          //       maxLines: 1,
                                          //       overflow: TextOverflow.ellipsis,
                                          //       style: Get.textTheme.bodySmall,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: 120,
                                      child: Text(
                                        element.value! > 0
                                            ? "+${Formater.formatMoney(element.value.toString())}"
                                            : Formater.formatMoney(
                                                element.value.toString()),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          color: color,
                                          fontWeight: FontWeight.w700,
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
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
