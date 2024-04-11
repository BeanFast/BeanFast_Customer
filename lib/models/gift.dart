import 'base_model.dart';
import 'exchange_gift.dart';

class Gift extends BaseModel {
  String? code;
  String? name;
  int? points;
  int? inStock;
  String? imagePath;
  String? description;
  List<ExchangeGift>? exchangeGifts;

  Gift({
    id,
    status,
    this.code,
    this.name,
    this.points,
    this.inStock,
    this.imagePath,
    this.description,
  });

  @override
  String toString() {
    return 'Gift(id: $id, code: $code, name: $name, point: $points, inStock: $inStock, imagePath: $imagePath, status: $status)';
  }

  factory Gift.fromJson(dynamic json) => Gift(
        id: json['id'],
        code: json["code"],
        name: json['name'],
        points: json['points'],
        inStock: json['inStock'],
        imagePath: json['imagePath'] ?? "",
        status: json['status'],
        description: json['description'],
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
