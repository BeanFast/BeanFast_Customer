
import '../utils/constants.dart';
import '/models/school.dart';

class SchoolService {
  final String baseUrl = 'schools';

  Future<List<School>> getAll() async {
    final response = await apiService.request.get(baseUrl);
    List<School> list = [];
    for (var e in response.data['data']) {
      list.add(School.fromJson(e));
    }
    return list;
  }

  Future<School> getById(String id) async {
    final response = await apiService.request.get('$baseUrl/$id');
    return School.fromJson(response.data['data']);
  }
}
