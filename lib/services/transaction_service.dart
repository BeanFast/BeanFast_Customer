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
}
