import 'package:beanfast_customer/models/food.dart';

import '/utils/constants.dart';

class FoodService {
  final String baseUrl = 'foods';

  // final ApiService _apiService = Get.put(ApiService());
  
  Future<Food> getById(String id) async {
    final response = await apiService.request.get('$baseUrl/$id');
    return Food.fromJson(response.data['data']);
  }
}
