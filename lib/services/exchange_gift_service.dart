import 'package:dio/dio.dart';

import '../utils/constants.dart';
import '/enums/status_enum.dart';
import '/models/exchange_gift.dart';

class ExchangeGiftService {
  final String baseUrl = 'ExchangeGifts';

  // final ApiService apiService = getx.Get.put(ApiService());

  Future<List<ExchangeGift>> getByStatus(
      ExchangeGiftStatus status, String profileId) async {
    final response = await apiService.request.get(
        "$baseUrl/profiles/$profileId",
        queryParameters:
            Map.from({"page": 1, "size": 100, 'status': status.code}));
    List<ExchangeGift> list = [];
    for (var e in response.data['data']['items']) {
      list.add(ExchangeGift.fromJson(e));
    }
    return list;
  }

  Future<ExchangeGift> getById(String id) async {
    final response = await apiService.request.get('$baseUrl/$id');
    ExchangeGift exchangeGift = ExchangeGift.fromJson(response.data['data']);
    return exchangeGift;
  }

  Future<bool> createExchangeGift(
      String giftId, String profileId, String sessionDetailId) async {
    Map<String, dynamic> data = {
      'giftId': giftId,
      'profileId': profileId,
      'sessionDetailId': sessionDetailId,
    };
    final response = await apiService.request.post(baseUrl, data: data);
    return response.statusCode == 200;
  }

  Future<bool> cancelExchangeGift(String exchangeGiftId, String reason) async {
    Map<String, dynamic> data = {
      'Reason': reason,
    };
    Response response = await apiService.request
        .put('$baseUrl/cancel/$exchangeGiftId', data: data);
    return response.statusCode == 200;
  }
}
