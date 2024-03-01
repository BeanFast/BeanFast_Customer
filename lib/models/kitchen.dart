import 'base_model.dart';
import 'menu.dart';
import 'school.dart';

class Kitchen extends BaseModel {
  String? areaId;
  String? code;
  String? name;
  String? address;
  String? imagePath;
  List<School>? schools;
  List<Menu>? menus;

  Kitchen({
    id,
    status,
    this.areaId,
    this.code,
    this.name,
    this.address,
    this.imagePath,
  }) : super(id: id, status: status);

  factory Kitchen.fromJson(dynamic json) => Kitchen(
        id: json['id'],
        status: json['status'],
        areaId: json["areaId"],
        code: json['code'],
        name: json['name'],
        address: json['address'],
        imagePath: json['imagePath'] ?? "",
      );

  // Map<String, dynamic> toJson() {
  //   return {
  //     "accessToken": accessToken.toString(),
  //     "id": id.toString(),
  //     "storeId": storeId.toString(),
  //     "name": name,
  //     "username": userName,
  //     "role": userRole,
  //     "status": status,
  //     "picUrl": picUrl ?? "",
  //   };
  // }
}
