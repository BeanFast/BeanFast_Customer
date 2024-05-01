import 'base_model.dart';
import '/contains/contrain.dart';
import 'profile.dart';
import 'qrcode.dart';

class User extends BaseModel {
  String? roleId;
  String? code;
  String? fullName;
  String? phone;
  String? email;
  String? avatarPath;
  // String? deviceToken;
  double? balance;
  List<Profile>? profiles;
  UserQrCode? qrCode;

  User({
    id,
    status,
    this.roleId,
    this.code,
    this.fullName,
    this.phone,
    this.email,
    this.avatarPath,
    this.balance,
    this.profiles,
    this.qrCode,
  }) : super(id: id, status: status);

  factory User.fromJson(dynamic json) {
    return User(
      id: json["id"],
      status: json['status'],
      roleId: json["roleId"],
      code: json['code'],
      fullName: json['fullName'],
      phone: json['phone'],
      email: json['email'],
      avatarPath: json['avatarPath'] ?? defaultAvatarImagePath,
      balance: json['balance'] == null
          ? 0
          : double.parse(json['balance'].toString()),
      profiles: [],
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
