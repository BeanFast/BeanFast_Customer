import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '/utils/cache_manager.dart';
import '/services/order_service.dart';
import '/utils/logger.dart';
import '/models/session.dart';
import '/models/menu_detail.dart';
import '/models/profile.dart';
import '/services/session_service.dart';
import '/services/profile_service.dart';

class CartController extends GetxController with CacheManager {
  RxInt itemCount = 0.obs;
  RxDouble total = RxDouble(0);
  double totalPrice = 0;
  Map<String, Profile> listProfile = <String, Profile>{}; // key: profileId
  Map<String, Session> listSession = <String, Session>{}; // key: sessionId
  Map<String, MenuDetail> listMenuDetail = <String, MenuDetail>{};
  RxMap<String, String> listSessionDetailId =
      <String, String>{}.obs; // key: sessionId, value: sessionDetailId
  RxMap<String, Map<String, RxMap<String, RxInt>>> dataList =
      <String, Map<String, RxMap<String, RxInt>>>{}.obs;

  Future checkCartItem() async {
    for (var profile in dataList.entries.toList()) {
      for (var session in profile.value.entries.toList()) {
        for (var menuDetail in session.value.entries.toList()) {
          bool result;
          try {
            result = await SessionService()
                .checkCartItem(profile.key, session.key, menuDetail.key);
          } catch (e) {
            result = false;
          }
          if (!result) {
            removeItemFromCart(profile.key, session.key, menuDetail.key);
          }
        }
      }
    }

    cleanCart();
     saveCart(dataList);
    updateItemCount();
  }

  void resetData() {
    dataList.value = {};
    itemCount.value = 0;
    total.value = 0;
  }

  Future fetchCartData() async {
    resetData();
    RxMap<String, Map<String, RxMap<String, RxInt>>>? cacheDataList =
        getCart(currentUser.value!.phone.toString());
    if (cacheDataList == null) {
      return;
    }
    dataList = cacheDataList;
    logger.e('getCart - $dataList');
    await checkCartItem();
    logger.e('checkCartItem - $dataList');
    updateTotal();
    updateItemCount();
  }

  Future fetchData() async {
    for (var profile in dataList.entries) {
      try {
        Profile profileData = await ProfileService().getById(profile.key);
        listProfile.putIfAbsent(profile.key, () => profileData);
      } catch (e) {
        //lỗi sẽ xóa dữ liệu trong cart
        dataList.remove(profile.key);
      }
      for (var session in profile.value.entries) {
        try {
          Session sessionData = await SessionService().getById(session.key);
          listSession.putIfAbsent(sessionData.id!, () => sessionData);
          listSessionDetailId.putIfAbsent(
              sessionData.id!, () => sessionData.sessionDetails![0].id!);
          for (var menuDetail in sessionData.menu!.menuDetails!.toList()) {
            if (session.value.containsKey(menuDetail.id)) {
              listMenuDetail.putIfAbsent(menuDetail.id!, () => menuDetail);
            }
          }
        } catch (e) {
          //lỗi sẽ xóa dữ liệu trong cart
          profile.value.remove(session.key);
          cleanCart();
        }
      }
    }
  }

  void updateSessionDetail(String sessionId, String sessionDetailId) {
    listSessionDetailId.update(
      sessionId,
      (value) => sessionDetailId,
      ifAbsent: () => sessionDetailId,
    );
  }

  Future<bool> checkout() async {
    try {
      await checkCartItem();
      for (var cart in dataList.entries) {
        for (var session in cart.value.entries) {
          Map<String, int> map = {};
          for (var menuDetail in session.value.entries) {
            map[menuDetail.key] = menuDetail.value.value;
          }
          bool result = await OrderService()
              .create(listSessionDetailId[session.key]!, cart.key, map);
          logger.e(result.toString());
        }
      }
      dataList.clear();
      saveCart(dataList);
      return true;
      // changePage(MenuIndexState.order.index);
      // Get.offAll(const SplashScreen());
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
      return false;
    }
  }

  void updateTotal() {
    total.value = 0;
    totalPrice = 0;
    dataList.forEach((profileId, listSession) {
      listSession.forEach((sessionId, cart) {
        cart.forEach((key, value) {
          if (listMenuDetail[key] != null) {
            totalPrice += value * listMenuDetail[key]!.food!.price!;
            total.value += value * listMenuDetail[key]!.price!;
          }
        });
      });
    });
  }

  void updateItemCount() {
    itemCount.value = 0;
    dataList.forEach((profileId, listSession) {
      listSession.forEach((sessionId, cart) {
        itemCount += cart.length;
      });
    });
  }

  void cleanCart() {
    if (dataList.values.isEmpty) {
      dataList.clear();
    } else {
      for (var profile in dataList.entries.toList()) {
        if (profile.value.isNotEmpty) {
          for (var session in profile.value.entries.toList()) {
            if (session.value.isEmpty) {
              profile.value.remove(session.key);
              cleanCart();
            } else {
              // return;
            }
          }
        } else {
          dataList.remove(profile.key);
          // return;
        }
      }
    }
  }

  Future<void> increaseItemCart(
      String profileId, String sessionId, String menuDetailId) async {
    if (dataList.containsKey(profileId)) {
      //if profileId đã có
      if (dataList[profileId]!.containsKey(sessionId)) {
        //sessionId đã có
        dataList[profileId]![sessionId]!
            .update(menuDetailId, (value) => value + 1, ifAbsent: () => 1.obs);
      } else {
        //if sessionId chưa tồn tại
        dataList[profileId]!
            .putIfAbsent(sessionId, () => {menuDetailId: 0.obs}.obs);
             dataList[profileId]![sessionId]![menuDetailId]!.value =1 ;
      }
    } else {
      //profileId chưa tồn tại
      dataList.putIfAbsent(
          profileId,
          () => {
                sessionId: {menuDetailId: 1.obs}.obs
              });
    }
    saveCart(dataList);
    updateItemCount();
    updateTotal();
  }

  Future<void> decreaseItemCart(
      String profileId, String sessionId, String menuDetailId) async {
    if (dataList.containsKey(profileId)) {
      //if profileId đã có
      if (dataList[profileId]!.containsKey(sessionId)) {
        //sessionId đã có
        if (dataList[profileId]![sessionId]!.containsKey(menuDetailId)) {
          if (dataList[profileId]![sessionId]![menuDetailId]!.value - 1 != 0) {
            dataList[profileId]![sessionId]!
                .update(menuDetailId, (value) => value - 1);
          } else {
            //remove
            dataList[profileId]![sessionId]!.remove(menuDetailId);
            cleanCart();
          }
        }
      }
    }
    saveCart(dataList);
    updateItemCount();
    updateTotal();
  }

  Future<void> removeItemFromCart(
      String profileId, String sessionId, String menuDetailId) async {
    dataList[profileId]?[sessionId]?.remove(menuDetailId);
    cleanCart();
    saveCart(dataList);
    updateItemCount();
    updateTotal();
  }

  bool ifAbse1nt(String profileId, String sessionId, String menuDetailId) {
    dataList[profileId]?[sessionId]?[menuDetailId] ?? 0;
    if (dataList.containsKey(profileId)) {
      if (dataList[profileId]!.containsKey(sessionId)) {
        return dataList[profileId]![sessionId]!.containsKey(menuDetailId);
      }
    }
    return false;
  }

  @override
 void onClose()  {
    saveCart(dataList);
    super.onClose();
  }
}
