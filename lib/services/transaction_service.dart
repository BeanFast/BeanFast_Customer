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

  Future<List<Transaction>> getTransactions(
      String page, String size, String type, String profileId) async {
    var response = await _apiService.request.get("$baseUrl/profiles/$profileId",
        queryParameters: Map.from({"page": page, "size": size, "type": type}));
    List<Transaction> result = List.empty();
    if (response.statusCode == 200) {
      for (var e in response.data['data']["items"]) {
        result.add(Transaction.fromJson(e));
      }
    }
    return result;
  }
}
