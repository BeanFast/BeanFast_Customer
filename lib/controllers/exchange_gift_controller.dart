import 'package:beanfast_customer/models/gift.dart';
import 'package:beanfast_customer/services/gift_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

class ExchangeGiftController extends getx.GetxController {
  getx.RxBool isError = false.obs;
  getx.RxList<Gift> listData = <Gift>[].obs;

  // Future<Profile?> getProfile() async {
  //   await ProfileService().getById(currentProfile.id);
  //   return profile;
  // }

  Future getData() async {
    try {
      listData.value = await GiftService().getAll();
    } catch (e) {
      isError.value = true;
    }
  }

  Future<bool> exchangeGift(String id) async {
    try {
      Response response = await GiftService()
          .exchangeGift('giftId', 'profileId', 'sessionDetailId');
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
