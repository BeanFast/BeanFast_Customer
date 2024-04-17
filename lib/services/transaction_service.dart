import 'package:beanfast_customer/models/transaction.dart';
import 'package:beanfast_customer/services/api_service.dart';
import 'package:get/get.dart';

class TransactionService {
  final String baseUrl = 'transactions';
  final ApiService _apiService = Get.put(ApiService());

  Future<dynamic> createVnpayRequest(int amount) async {
    var response =
        await _apiService.request.post("$baseUrl/payment?amount=$amount");
    return response.data['data'];
  }

  Future<List<Transaction>> getTransactions(int page, int size) async {
    var response = await _apiService.request
        .get(baseUrl, queryParameters: Map.from({"page": page, "size": size}));
    List<Transaction> result = List.empty(growable: true);
    if (response.statusCode == 200) {
      for (var e in response.data['data']["items"]) {
        // var tran = Transaction.fromJson(e);
        result.add(Transaction.fromJson(e));
      }
    }
    return result;
  }
}
