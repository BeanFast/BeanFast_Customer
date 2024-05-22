import 'package:get/get.dart';

import '/services/auth_service.dart';
import '/utils/constants.dart';
import '/services/transaction_service.dart';

class GameMenuController extends GetxController {
  RxInt playTimes = 0.obs;

  Future fetchData() async {
    try {
      playTimes.value = await TransactionService().getPlayTime();
      currentUser.value = await AuthService().getUser();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future sendPoints(String gameId, int points) async {
    try {
      await TransactionService().createGameTransaction(gameId, points);
      await fetchData();
    } catch (e) {
      throw Exception(e);
    }
  }
}
