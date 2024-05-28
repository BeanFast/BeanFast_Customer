import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../enums/menu_index_enum.dart';
import '../views/screens/gift_exchange_screen.dart';
import '../views/screens/splash_screen.dart';
import '/models/transaction.dart';
import '/services/transaction_service.dart';
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
   RxBool isSubmitting = false.obs;
  //exchange gift tabview
  ExchangeGiftStatus orderStatus = ExchangeGiftStatus.preparing;
  PagingController<int, ExchangeGift> pagingExchangeGiftController =
      PagingController(firstPageKey: 1);
  final TextEditingController otherReasonController = TextEditingController();
  RxBool isLoading = true.obs;
  //transaction tabview
  PagingController<int, Transaction> pagingTransactionController =
      PagingController(firstPageKey: 1);
  //gift tabview
  PagingController<int, Gift> pagingGiftController =
      PagingController(firstPageKey: 1);
  //checkout
  Rx<ExchangeGift?> model = Rx<ExchangeGift?>(null);
  Rx<Session?> selectedSession = Rx<Session?>(null);
  RxList<Session> listSession = <Session>[].obs;
  Rx<String?> sessionDetailId = Rx<String?>(null);
  String? messages;
  bool? isError;

  final RxInt selectedValue = RxInt(-1);

  void handleRadioValueChanged(int? value) {
    if (value != null) {
      selectedValue.value = value;
    }
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
    sessionDetailId.value = session.sessionDetails!.first.id;
  }

  void resetGiftPagingController() {
    pagingGiftController.dispose();
    pagingGiftController = PagingController(firstPageKey: 1);
    pagingGiftController.addPageRequestListener((pageKey) async {
      await getGifts(pageKey);
    });
  }

  void resetTransactionController() {
    pagingTransactionController.dispose();
    pagingTransactionController = PagingController(firstPageKey: 1);
    pagingTransactionController.addPageRequestListener((pageKey) async {
      await getTransactions(pageKey);
    });
  }

  void resetExchangeGiftPagingController() {
    pagingExchangeGiftController.dispose();
    pagingExchangeGiftController = PagingController(firstPageKey: 1);
    pagingExchangeGiftController.addPageRequestListener((pageKey) async {
      await getExchangeGiftByStatus(pageKey);
    });
  }

  Future<void> getGifts(int pageKey) async {
    try {
      final newData = await GiftService().getAll(pageKey, 5);

      final isLastPage = newData.isEmpty;
      if (isLastPage) {
        pagingGiftController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingGiftController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      pagingGiftController.error = error;
    }
  }

  Future<void> getTransactions(int pageKey) async {
    try {
      final newData =
          await TransactionService().getTransactions(pageKey, 5, false);

      final isLastPage = newData.isEmpty;
      if (isLastPage) {
        pagingTransactionController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingTransactionController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      pagingTransactionController.error = error;
    }
  }

  Future<void> getExchangeGiftByStatus(int pageKey) async {
    try {
      final newData =
          await ExchangeGiftService().getByStatus(orderStatus, pageKey, 5);

      final isLastPage = newData.isEmpty;
      if (isLastPage) {
        pagingExchangeGiftController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        pagingExchangeGiftController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      pagingExchangeGiftController.error = error;
    }
  }

  Future getById(String id) async {
    model.value = null;
    try {
      var data = await ExchangeGiftService().getById(id);
      model.value = data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> createExchangeGift(String giftId) async {
    try {
      bool result = await ExchangeGiftService().createExchangeGift(
          giftId, currentProfile.value!.id!, sessionDetailId.value!);
      return result;
    } on dio.DioException catch (e) {
      messages = e.response!.data['message'];
      return false;
    }
  }

  Future cancelExchangeGift(String id) async {
    if (selectedValue.value == -1) {
      Get.snackbar('Thông báo', 'Vui lòng nhập lý do');
    } else if (selectedValue.value == 3 && otherReasonController.text.isEmpty) {
      Get.snackbar('Hệ thống', 'Vui lòng nhập lý do huỷ',
          duration: const Duration(seconds: 1));
    } else {
      String reason;
      if (selectedValue.value != 3) {
        reason = cancelExchangeGiftReasonOptions[selectedValue.value]['title']
            as String;
      } else {
        reason = otherReasonController.text;
      }
      //call api
      try {
        await ExchangeGiftService().cancelExchangeGift(id, reason);
        Get.snackbar('Hệ thống', 'Huỷ đơn hàng thành công');
        changePage(MenuIndexState.home.index);
        Get.offAll(const SplashScreen());
        Get.to(const ExchangeGiftScreen());
      } on DioException catch (e) {
        Get.snackbar('Lỗi', e.response!.data['message']);
      }
    }
  }

  @override
  void onClose() {
    // pagingTransactionController.dispose();
    // pagingGiftController.dispose();
    // pagingExchangeGiftController.dispose();
    super.onClose();
  }
}
