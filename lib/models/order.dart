import 'base_model.dart';
import 'order_activity.dart';
import 'order_detail.dart';
import 'profile.dart';
import 'session_detail.dart';
import 'transaction.dart';

class Order extends BaseModel {
  String? sessionDetailId;
  String? profileId;
  String? code;
  double? totalPrice;
  DateTime? paymentDate;
  DateTime? deliveryDate;
  int? rewardPoints;
  String? feedback;
  SessionDetail? sessionDetail;
  Profile? profile;
  List<OrderDetail>? orderDetails;
  List<Transaction>? transactions;
  List<OrderActivity>? orderActivities;

  Order({
    id,
    status,
    this.sessionDetailId,
    this.profileId,
    this.code,
    this.totalPrice,
    this.paymentDate,
    this.deliveryDate,
    this.rewardPoints,
    this.feedback,
    this.sessionDetail,
    this.profile,
    this.orderDetails,
    this.transactions,
    this.orderActivities,
  }) : super(id: id, status: status);

  factory Order.fromJson(dynamic json) {
    if (json == null) {
      if (json == null) {
        return Order(); // Return a default instance of Order
      }
    }
    return Order(
      id: json['id'],
      status: json['status'],
      sessionDetailId: json['sessionDetailId'] ?? null,
      profileId: json['profileId'] ?? null,
      code: json['code'] ?? null,
      totalPrice: json['totalPrice'] != null
          ? double.parse(json['totalPrice'].toString())
          : null,
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'])
          : null,
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      rewardPoints: json['rewardPoints'] != null
          ? int.parse(json['rewardPoints'].toString())
          : null,
      feedback: json['feedback'] ?? '',
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      orderDetails: json['orderDetails']?.map<OrderDetail>((item) {
        return OrderDetail.fromJson(item);
      }).toList(),
      orderActivities: json['orderActivities']?.map<OrderActivity>((item) {
        return OrderActivity.fromJson(item);
      }).toList(),
      sessionDetail: json['sessionDetail'] == null
          ? SessionDetail()
          : SessionDetail.fromJson(json['sessionDetail']),
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
