import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '/models/session.dart';
import '/services/session_service.dart';
import '/enums/status_enum.dart';
import '/models/gift.dart';
import '/services/gift_service.dart';
import '/services/exchange_gift_service.dart';
import '/models/exchange_gift.dart';
import '/utils/logger.dart';
import '/utils/constants.dart';

class ExchangeGiftController extends GetxController {
  ExchangeGiftStatus orderStatus = ExchangeGiftStatus.preparing;
  RxList<Gift> listData = <Gift>[].obs;
  RxList<ExchangeGift> listExchangeGiftData = <ExchangeGift>[].obs;
  //checkout
  Rx<ExchangeGift> model = ExchangeGift().obs;
  Rx<Session?> selectedSession = Rx<Session?>(null);
  RxList<Session> listSession = <Session>[].obs;
  String? sessionDetailId;
  String? messages;
  bool? isError;

  final RxInt _selectedValue = RxInt(-1);
  final RxString _otherReason = RxString('');

  int get selectedValue => _selectedValue.value;
  String get otherReason => _otherReason.value;

  void handleRadioValueChanged(int? value) {
    if (value != null) {
      _selectedValue.value = value;
      if (value != 3) {
        _otherReason.value = '';
      }
      update();
    }
  }

  void handleOtherReasonChanged(String reason) {
    _otherReason.value = reason;
    update();
  }

  void clear() {
    listSession.clear();
    selectedSession.value = null;
    messages = null;
    isError = null;
  }

  Future getSession(String schoolId, DateTime dateTime) async {
    clear();
    try {
      listSession.value =
          await SessionService().getSessionsBySchoolId(schoolId, dateTime);
      logger.e(listSession.length);
    } on dio.DioException catch (e) {
      throw Exception(e);
    }
  }

  void selectSession(Session session) {
    selectedSession.value = session;
    sessionDetailId = session.sessionDetails!.first.id;
  }

  Future getData() async {
    try {
      listData.value = await GiftService().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getById(String id) async {
    try {
      var data =  await ExchangeGiftService().getById(id);
      model.value = data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getExchangeGiftByStatus() async {
    try {
      listExchangeGiftData.value =
          await ExchangeGiftService().getByStatus(orderStatus);
      listExchangeGiftData
          .sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> createExchangeGift(String giftId) async {
    try {
      bool result = await ExchangeGiftService().createExchangeGift(
          giftId, currentProfile.value!.id!, sessionDetailId!);
      return result;
    } on dio.DioException catch (e) {
      messages = e.response!.data['message'];
      return false;
    }
  }
}
