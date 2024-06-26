import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';
import '/services/transaction_service.dart';

class TransactionController extends GetxController {
  PagingController<int, Transaction> pagingController =
      PagingController(firstPageKey: 1);
  Map<String, List<Transaction>> initListTransaction = {};
  RxMap<String, List<Transaction>> mapTransactions =
      <String, List<Transaction>>{}.obs;
  RxInt indexSelectedSortByMonth = 0.obs;
  RxInt indexSelectedSortByStatus = 0.obs;
  List<String> listMonth = [];
  List<String> listStatus = ['Tất cả', 'Nạp tiền', 'Mua hàng'];

  void resetPagingController() {
    pagingController.dispose();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) async {
      await fetchData(pageKey);
    });
  }

  Future<void> fetchData(int pageKey) async {
    listMonth.clear();
    listMonth.add('Tất cả');
    indexSelectedSortByMonth = 0.obs;
    indexSelectedSortByStatus = 0.obs;
    try {
      final newData =
          await TransactionService().getTransactions(pageKey, 5, true);

      final isLastPage = newData.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newData, nextPageKey);
        setInitListTransaction(newData);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void setInitListTransaction(List<Transaction> list) {
    mapTransactions.clear();
    initListTransaction.clear();
    for (var e in list) {
      String key = DateFormat('MM/yyyy').format(e.time!);
      if (initListTransaction.containsKey(key)) {
        initListTransaction[key]!.add(e);
      } else {
        initListTransaction.putIfAbsent(key, () => [e]);
        listMonth.add(key);
      }
    }
    mapTransactions.addAll(initListTransaction);
  }

  void search(String value) {
    mapTransactions.clear();
    if (value.isEmpty) {
      mapTransactions.addAll(initListTransaction);
    } else {
      List<Transaction> list = [];
      // for (var e in initListTransaction.values) {
      //   e
      //       .where((transaction) => transaction.order!.code!
      //           .toLowerCase()
      //           .contains(value.toLowerCase()))
      //       .toList();
      // }

      // .where((e) =>
      //     e.code!.toLowerCase().contains(value.toLowerCase()) ||
      //     e.name!.toLowerCase().contains(value.toLowerCase()))
      // .toList();

      // setDataTable(currentModelList);
    }
  }

  void filterTransactions() {
    mapTransactions.clear();
    if (indexSelectedSortByMonth.value == 0 &&
        indexSelectedSortByStatus.value == 0) {
      mapTransactions.addAll(initListTransaction);
      return;
    }
    if (indexSelectedSortByMonth.value != 0) {
      List<Transaction> list = [];
      list.addAll(
          initListTransaction[listMonth[indexSelectedSortByMonth.value]]!);
      mapTransactions.putIfAbsent(
          listMonth[indexSelectedSortByMonth.value], () => list);
    } else {
      mapTransactions.addAll(initListTransaction);
    }
    if (indexSelectedSortByStatus.value != 0) {
      for (var e in mapTransactions.entries.toList()) {
        for (var transaction in e.value.toList()) {
          if (indexSelectedSortByStatus.value == 1) {
            if (transaction.value! < 0) {
              e.value.remove(transaction);
            }
          } else {
            if (transaction.value! > 0) {
              e.value.remove(transaction);
            }
          }
        }
        if (e.value.isEmpty) {
          mapTransactions.remove(e.key);
        }
      }
      int a = initListTransaction.length;
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
