import 'base_model.dart';
import 'transaction.dart';

class Game extends BaseModel {
  String? code;
  String? name;
  String? description;
  List<Transaction>? transactions;
  Game({
    id,
    status,
    this.code,
    this.name,
    this.description,
    this.transactions,
  }) : super(id: id, status: status);

  factory Game.fromJson(dynamic json) => Game(
        id: json["id"],
        status: json['status'],
        code: json["code"],
        name: json["name"],
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
