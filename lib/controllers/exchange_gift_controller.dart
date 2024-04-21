import 'package:beanfast_customer/models/exchange_gift.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/enums/status_enum.dart';
import '/models/gift.dart';
import '/services/gift_service.dart';
import '/services/exchange_gift_service.dart';

class ExchangeGiftController extends getx.GetxController {
  ExchangeGiftStatus orderStatus = ExchangeGiftStatus.preparing;
  getx.RxBool isError = false.obs;
  getx.RxList<Gift> listData = <Gift>[].obs;
  getx.RxList<ExchangeGift> listExchangeGiftData = <ExchangeGift>[].obs;

  Future getData() async {
    try {
      listData.value = await GiftService().getAll();
    } catch (e) {
      isError.value = true;
    }
  }

  // Future getExchangeGiftHistory() async {
  //   try {
  //     listData.value = await ExchangeGiftService().getAll();
  //   } catch (e) {
  //     isError.value = true;
  //   }
  // }

  Future getExchangeGiftByStatus() async {
    try {
      listExchangeGiftData.value = await ExchangeGiftService().getByStatus(orderStatus);
      listExchangeGiftData.sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> exchangeGift(String id) async {
    try {
      Response response = await ExchangeGiftService()
          .createExchangeGift('giftId', 'profileId', 'sessionDetailId');
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
