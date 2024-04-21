import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/enums/status_enum.dart';
import '/models/exchange_gift.dart';
import '/services/api_service.dart';

class ExchangeGiftService {
  final String baseUrl = 'ExchangeGifts';

  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<ExchangeGift>> getByStatus(ExchangeGiftStatus status) async {
    final response = await _apiService.request.get(baseUrl,
        queryParameters:
            Map.from({"page": 1, "size": 100, 'status': status.code}));
    List<ExchangeGift> list = [];
    for (var e in response.data['data']['items']) {
      list.add(ExchangeGift.fromJson(e));
    }
    return list;
  }

  Future<Response> createExchangeGift(
      String giftId, String profileId, String sessionDetailId) async {
    Map<String, dynamic> data = {
      'giftId': giftId,
      'profileId': profileId,
      'sessionDetailId': sessionDetailId,
    };
    final response = await _apiService.request.post(baseUrl, data: data);
    return response;
  }
}
