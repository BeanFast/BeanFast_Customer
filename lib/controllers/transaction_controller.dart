import 'package:beanfast_customer/models/transaction.dart';
import 'package:beanfast_customer/services/transaction_service.dart';
import 'package:beanfast_customer/utils/logger.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  RxList<Transaction> transactions = <Transaction>[].obs;
  RxMap<String, List<Transaction>> mapTransactions =
      <String, List<Transaction>>{}.obs;
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

  Future getTransaction() async {
    mapTransactions.clear();
    try {
      transactions.value = await TransactionService().getTransactions(
          1, 100);

      for (var e in transactions) {
        String key = DateFormat('MM/yyyy').format(e.time!);
        if (mapTransactions.containsKey(key)) {
          mapTransactions[key]!.add(e);
        } else {
          mapTransactions.putIfAbsent(key, () => [e]);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  int indexSelectedSortByMonth = 0;
  int indexSelectedSortByStatus = 0;
}
