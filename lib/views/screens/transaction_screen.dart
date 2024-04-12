import 'package:beanfast_customer/controllers/transaction_controller.dart';
import 'package:beanfast_customer/utils/formater.dart';
import 'package:beanfast_customer/views/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
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
                        transactionController.isMoneyVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 16,
                      ),
                      onPressed: () {
                        transactionController.toggleMoneyVisibility();
                      },
                    ),
                    Text(
                      transactionController.moneyValue.value,
                      style: Get.textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //tháng 3
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 198, 229, 245),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 198, 229, 245),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
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
                        children:
                            transactionController.transactions.map((element) {
                          var index = -1;
                          index++;
                          var transactionType = element.order!.code == null
                              ? "Nạp tiền"
                              : "Thanh toán";
                          IconData iconData = element.order!.code == null
                              ? Iconsax.wallet_add_1
                              : Iconsax.wallet_minus;
                          var color =
                              element.value! > 0 ? Colors.green : Colors.red;
                          return Card(
                            color: index % 2 == 0
                                ? Colors.white
                                : const Color.fromARGB(255, 198, 225, 244)
                                    .withOpacity(0.3),
                            child: Container(
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
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              Get.textTheme.bodyLarge!.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    formatter
                                                        .format(element.time!),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        Get.textTheme.bodySmall,
                                                  ),
                                                  const SizedBox(height: 5),
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
                                                        element.value
                                                            .toString()),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.textTheme.bodyMedium!
                                                    .copyWith(
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
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
