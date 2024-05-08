import 'package:get/get.dart';

import '/models/transaction.dart';
import '/services/api_service.dart';

class TransactionService {
  final String baseUrl = 'transactions';
  final ApiService _apiService = Get.put(ApiService());

  Future<dynamic> createVnpayRequest(int amount) async {
    var response =
        await _apiService.request.post("$baseUrl/payment?amount=$amount");
    return response.data['data'];
  }

  Future<bool> createGameTransaction(
      String profileId, String gameId, int points) async {
    Map<String, dynamic> data = {
      'profileId': profileId,
      'gameId': gameId,
      'points': points,
    };
    final response =
        await _apiService.request.post('$baseUrl/games', data: data);
    return response.statusCode == 200;
  }

  Future<List<Transaction>> getTransactions(int page, int size, bool isMoney) async {
    var response = await _apiService.request.get(baseUrl,
        queryParameters:
            Map.from({"page": page, "size": size, 'type': isMoney ? 'money' : 'points'}));
    List<Transaction> result = List.empty(growable: true);
    if (response.statusCode == 200) {
      for (var e in response.data['data']["items"]) {
        result.add(Transaction.fromJson(e));
      }
    }
    return result;
  }

  // Future<List<Transaction>> getPointTransactions(
  //     String profileId, int page, int size) async {
  //   var response = await _apiService.request.get('$baseUrl/profiles/$profileId',
  //       queryParameters:
  //           Map.from({"page": page, "size": size, 'type': 'points'}));
  //   List<Transaction> result = List.empty(growable: true);
  //   if (response.statusCode == 200) {
  //     for (var e in response.data['data']["items"]) {
  //       result.add(Transaction.fromJson(e));
  //     }
  //     logger.e(result.length);
  //   }
  //   return result;
  // }

  Future<int> getPlayTime(String profileId) async {
    var response = await _apiService.request
        .get('$baseUrl/games/count/profiles/$profileId');
    var result = 0;
    if (response.statusCode == 200) {
      result = response.data['data'];
    }
    return result;
  }
}
