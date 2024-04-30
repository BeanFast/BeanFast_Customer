import 'base_model.dart';
import 'kitchen.dart';
import 'menu_detail.dart';
import 'session.dart';
import 'user.dart';

class Menu extends BaseModel {
  String? kitchenId;
  String? createrId;
  String? updaterId;
  String? code;
  DateTime? createdDate;
  DateTime? updatedDate;
  User? creater;
  User? updater;
  Kitchen? kitchen;
  List<Session>? schools;
  List<MenuDetail>? menuDetails;

  Menu({
    id,
    status,
    this.kitchenId,
    this.createrId,
    this.updaterId,
    this.code,
    this.createdDate,
    this.updatedDate,
    this.menuDetails,
  }) : super(id: id, status: status);

  factory Menu.fromJson(dynamic json) {
    return Menu(
      id: json['id'],
      status: json['status'],
      kitchenId: json["kitchenId"],
      createrId: json['createrId'],
      updaterId: json['updaterId'],
      code: json['code'],
      // createdDate: DateTime.parse(json['createdDate']),
      // updatedDate: DateTime.parse(json['updatedDate']),
      menuDetails: json['menuDetails']?.map<MenuDetail>((item) {
        return MenuDetail.fromJson(item);
      }).toList(),
    );
  }

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
