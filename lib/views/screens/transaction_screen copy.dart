import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/contains/theme_color.dart';
import '/models/transaction.dart';
import '/services/transaction_service.dart';
import '/utils/formater.dart';
import 'data_screen.dart';

class MyListView extends GetView<MyController> {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Iconsax.filter_search,
            ),
            onPressed: () {
              // showFilterDialog(context);
            },
          ),
        ],
      ),
      body: PagedListView<int, Transaction>(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Transaction>(
          itemBuilder: (context, item, index) {
            var transactionType = item.order!.code == null
                ? "Nạp tiền"
                : item.value! >= 0
                    ? "Hoàn tiền"
                    : "Thanh toán";
            IconData iconData =
                item.value! > 0 ? Iconsax.wallet_add_1 : Iconsax.wallet_minus;
            var color = item.value! >= 0 ? Colors.green : Colors.red;
            return Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Icon(
                        iconData,
                        color: ThemeColor.iconColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.order!.code != null
                                ? "$transactionType: #${item.order!.code!}"
                                : transactionType,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('HH:mm dd/MM/yy')
                                          .format(item.time!),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                width: 120,
                                child: Text(
                                  item.value! > 0
                                      ? "+${Formater.formatMoney(item.value.toString())}"
                                      : Formater.formatMoney(
                                          item.value.toString()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyMedium!.copyWith(
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
          },
          noItemsFoundIndicatorBuilder: (context) => const DataScreen(
            hasData: false,
            message: 'Chưa có lịch sử',
            child: Center(),
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Lỗi tải trang'),
          ),
          newPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Lỗi tải trang mới'),
          ),
        ),
      ),
    );
  }
}

class MyController extends GetxController {
  final PagingController<int, Transaction> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> fetchData(int pageKey) async {
    try {
      final newData =
          await TransactionService().getTransactions(pageKey, 5, true);

      final isLastPage = newData.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) async {
      await fetchData(pageKey);
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
