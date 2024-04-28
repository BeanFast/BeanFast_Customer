import 'base_model.dart';
import 'game.dart';
import 'order.dart';
import 'wallet.dart';
import 'exchange_gift.dart';

class Transaction extends BaseModel {
  String? orderId;
  String? exchangeGiftId;
  String? gameId;
  String? walletId;
  String? code;
  DateTime? time;
  double? value;
  Order? order;
  ExchangeGift? exchangeGift;
  Game? game;
  Wallet? wallet;

  Transaction({
    id,
    status,
    this.orderId,
    this.order,
    this.exchangeGiftId,
    this.exchangeGift,
    this.gameId,
    this.game,
    this.walletId,
    this.code,
    this.time,
    this.value,
  }) : super(id: id, status: status);

  factory Transaction.fromJson(dynamic json) => Transaction(
        id: json["id"],
        status: json['status'],
        orderId: json["orderId"],
        order: json["order"] == null ? Order() : Order.fromJson(json["order"]),
        exchangeGiftId: json['exchangeGiftId'],
        exchangeGift: json["exchangeGift"] == null
            ? ExchangeGift()
            : ExchangeGift.fromJson(json["exchangeGift"]),
        gameId: json['gameId'],
        game: json["game"] == null ? Game() : Game.fromJson(json["game"]),
        walletId: json['walletId'],
        code: json['code'],
        time: DateTime.parse(json['time']),
        value: double.parse(json['value'].toString()),
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
