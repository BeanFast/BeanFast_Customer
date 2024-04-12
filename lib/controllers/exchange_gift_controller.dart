import 'package:beanfast_customer/models/gift.dart';
import 'package:beanfast_customer/services/gift_service.dart';
import 'package:get/get.dart';

import '../utils/logger.dart';

class ExchangeGiftController extends GetxController {
  RxBool isError = false.obs;
  RxList<Gift> listData = <Gift>[].obs;

  // Future<Profile?> getProfile() async {
  //   await ProfileService().getById(currentProfile.id);
  //   return profile;
  // }

  Future getData() async {
    logger.i('getData');
    try {
      var response = await GiftService().getAll();
      List<Gift> list = [];
      for (var e in response.data['data']['items']) {
        // logger.i(e.toString());
        list.add(Gift.fromJson(e));
      }
      listData.value = list;
      logger.i(listData.length.toString());
    } catch (e) {
      isError.value = true;
    }
  }
}
