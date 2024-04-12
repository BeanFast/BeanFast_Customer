import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/utils/logger.dart';
import '/enums/status_enum.dart';
import '/models/food.dart';
import '/models/order.dart';
import '/services/api_service.dart';
import 'food_service.dart';

class OrderService {
  final String baseUrl = 'orders';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Order>> getByStatus(OrderStatus status) async {
    final response =
        await _apiService.request.get('$baseUrl?status=${status.code}');
    List<Order> list = [];
    for (var e in response.data['data']) {
      list.add(Order.fromJson(e));
    }
    return list;
  }

  Future<Order> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    Order order = Order.fromJson(response.data['data']);
    for (var i = 0; i < order.orderDetails!.length; i++) {
      var responseFood =
          await FoodService().getById(order.orderDetails![i].foodId!);
      order.orderDetails![i].food = Food.fromJson(responseFood.data['data']);
    }
    return order;
  }

  Future<Response> createOrder(String sessionDetailId, String profileId,
      Map<String, int> listCart) async {
    List<Map<String, dynamic>> orderDetails = [];
    listCart.forEach((key, value) {
      Map<String, dynamic> orderDetail = {
        "quantity": value,
        "note": "aa",
        "menuDetailId": key,
      };
      orderDetails.add(orderDetail);
    });
    Map<String, dynamic> data = {
      'sessionDetailId': sessionDetailId,
      'profileId': profileId,
      'orderDetails': orderDetails,
    };
    logger.e('data - $data');
    final response = await _apiService.request.post(baseUrl, data: data);
    return response;
  }
}
