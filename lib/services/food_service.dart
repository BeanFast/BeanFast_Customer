import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/services/api_service.dart';

class FoodService {
  final String baseUrl = 'foods';

  final ApiService _apiService = getx.Get.put(ApiService());

  // Future<dynamic> getAll() async {
  //   final response = await _apiService.request.get(baseUrl);
  //   return response.data;
  // }

  Future<Response> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return response;
  }
}
