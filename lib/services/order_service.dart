import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../utils/logger.dart';
import '/enums/status_enum.dart';
import '/services/api_service.dart';

class OrderService {
  final String baseUrl = 'orders';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<Response> getByStatus(OrderStatus status) async {
    final response =
        await _apiService.request.get('$baseUrl?status=${status.code}');
    return response;
  }

  Future<dynamic> getById(String id) async {
    final response = await _apiService.request.get('food/$id');
    return response.data;
  }
}
