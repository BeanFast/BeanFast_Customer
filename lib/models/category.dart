import 'base_model.dart';
import 'food.dart';

class Category extends BaseModel {
  String? code;
  String? name;
  String? imagePath;
  List<Food>? foods;

  Category({
    id,
    status,
    this.code,
    this.name,
    this.imagePath,
  }) : super(id: id, status: status);

  factory Category.fromJson(dynamic json) => Category(
        id: json['id'],
        status: json['status'],
        code: json["code"],
        name: json["name"],
        imagePath: json['imagePath'],
      );
}
