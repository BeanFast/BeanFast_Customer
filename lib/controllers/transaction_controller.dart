import 'package:beanfast_customer/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';
import '/services/transaction_service.dart';
import '/utils/logger.dart';

class TransactionController extends GetxController {
  Map<String, List<Transaction>> initListTransaction = {};
  RxMap<String, List<Transaction>> mapTransactions =
      <String, List<Transaction>>{}.obs;
  RxInt indexSelectedSortByMonth = 0.obs;
  RxInt indexSelectedSortByStatus = 0.obs;
  List<String> listMonth = [];
  List<String> listStatus = ['Tất cả', 'Nạp tiền', 'Mua hàng'];

  Future getTransaction() async {
    listMonth.clear();
    listMonth.add('Tất cả');
    try {
      List<Transaction> transactions =
          await TransactionService().getTransactions(1, 100);
      setInitListTransaction(transactions);
    } catch (e) {
      throw Exception(e);
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

  // void search(String value) {
  //   if (value.isEmpty) {
  //     setDataTable(initModelList);
  //   } else {
  //     currentModelList = initModelList
  //         .where((e) =>
  //             e.code!.toLowerCase().contains(value.toLowerCase()) ||
  //             e.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //     setDataTable(currentModelList);
  //   }
  // }

  void filterTransactions() {
    mapTransactions.clear();
    if (indexSelectedSortByMonth.value == 0 &&
        indexSelectedSortByStatus.value == 0) {
      mapTransactions.value = initListTransaction;
    } else {
      if (indexSelectedSortByMonth.value != 0) {
        mapTransactions.putIfAbsent(
            listMonth[indexSelectedSortByMonth.value],
            () => initListTransaction[
                listMonth[indexSelectedSortByMonth.value]]!);
      }
      // switch (indexSelectedSortByStatus.value) {
      //   case 1:
      //     {
      //       for (var e in mapTransactions.entries) {
      //         for (var transaction in e.value) {
      //           if (transaction.value! < 0) {
      //             e.value.remove(transaction);
      //           }
      //         }
      //       }
      //     }
      //     break;
      //   case 2:
      //     {
      //       for (var e in mapTransactions.entries) {
      //         for (var transaction in e.value) {
      //           if (transaction.value! > 0) {
      //             e.value.remove(transaction);
      //           }
      //         }
      //       }
      //     }
      //     break;
      //   default:
      // }
    }
  }

  Future getPointTransaction(String profileId) async {
    try {
      List<Transaction> transactions =
          await TransactionService().getPointTransactions(profileId, 1, 100);
      setInitListTransaction(transactions);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future createGameTransaction(String gameId, int points) async {
    try {
      bool result = await TransactionService()
          .createGameTransaction(currentProfile.value!.id!, gameId, points);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
