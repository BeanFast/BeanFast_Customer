import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/services/api_service.dart';

class GiftService {
  final String baseUrl = 'gifts';

  final ApiService _apiService = getx.Get.put(ApiService());

  Future<Response> getAll() async {
    final response = await _apiService.request.get('$baseUrl?page=1&size=100');
    return response;
  }

  Future<Response> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return response;
  }
}
