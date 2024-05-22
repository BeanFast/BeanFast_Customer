import '/utils/constants.dart';
import '/models/gift.dart';

class GiftService {
  final String baseUrl = 'gifts';

  Future<List<Gift>> getAll(
    int page,
    int size,
  ) async {
    final response = await apiService.request
        .get(baseUrl, queryParameters: Map.from({"page": page, "size": size}));
    List<Gift> list = [];
    for (var e in response.data['data']['items']) {
      list.add(Gift.fromJson(e));
    }
    return list;
  }

  // Future<Response> getById(String id) async {
  //   final response = await apiService.request.get('$baseUrl/$id');
  //   return response;
  // }
}
