import '../utils/constants.dart';
import '/models/transaction.dart';

class TransactionService {
  final String baseUrl = 'transactions';
  // final ApiService apiService = Get.put(ApiService());

  Future<dynamic> createVnpayRequest(int amount) async {
    var response =
        await apiService.request.post("$baseUrl/payment?amount=$amount");
    return response.data['data'];
  }

  Future<bool> createGameTransaction(String gameId, int points) async {
    Map<String, dynamic> data = {
      'gameId': gameId,
      'points': points,
    };
    final response =
        await apiService.request.post('$baseUrl/games', data: data);
    return response.statusCode == 200;
  }

  Future<List<Transaction>> getTransactions(
      int page, int size, bool isMoney) async {
    var response = await apiService.request.get(baseUrl,
        queryParameters: Map.from({
          "page": page,
          "size": size,
          'type': isMoney ? 'money' : 'points'
        }));
    List<Transaction> result = List.empty(growable: true);
    if (response.statusCode == 200) {
      for (var e in response.data['data']["items"]) {
        result.add(Transaction.fromJson(e));
      }
    }
    return result;
  }

  Future<int> getPlayTime() async {
    var response = await apiService.request
        .get('$baseUrl/games/count');
    var result = 0;
    if (response.statusCode == 200) {
      result = response.data['data'];
    }
    return result;
  }
}
