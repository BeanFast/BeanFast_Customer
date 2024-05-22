import 'package:dio/dio.dart';

import '../utils/constants.dart';
import '/utils/logger.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';

class OrderService {
  final String baseUrl = 'orders';
  // final ApiService apiService = getx.Get.put(ApiService());

  Future<List<Order>> getByStatus(
      OrderStatus status, int page, int size) async {
    final response = await apiService.request.get(baseUrl,
        queryParameters:
            Map.from({"page": page, "size": size, 'status': status.code}));
    List<Order> list = [];
    for (var e in response.data['data']['items']) {
      list.add(Order.fromJson(e));
    }
    return list;
  }

  Future<Order> getById(String id) async {
    final response = await apiService.request.get('$baseUrl/$id');
    Order order = Order.fromJson(response.data['data']);
    return order;
  }

  Future<bool> cancelOrder(String orderId, String reason) async {
    FormData formData = FormData.fromMap({
      'Reason': reason,
    });
    Response response = await apiService.request
        .put('$baseUrl/cancel/$orderId', data: formData);
    return response.statusCode == 200;
  }

  Future<bool> create(String sessionDetailId, String profileId,
      Map<String, int> listCart) async {
    List<Map<String, dynamic>> orderDetails = [];
    listCart.forEach((key, value) {
      Map<String, dynamic> orderDetail = {
        "quantity": value,
        "note": "",
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
    final response = await apiService.request.post(baseUrl, data: data);
    return response.statusCode == 201;
  }
}
