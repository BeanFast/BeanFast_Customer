import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
  RxMap<String, Map<String, RxMap<String, RxInt>>> listCart =
      <String, Map<String, RxMap<String, RxInt>>>{}.obs;

  Future checkCartItem() async {
    for (var profile in listCart.entries.toList()) {
      for (var session in profile.value.entries.toList()) {
        for (var cart in session.value.entries.toList()) {
          bool result;
          try {
            result = await SessionService()
                .checkCartItem(profile.key, session.key, cart.key);
          } on DioException catch (e) {
            result = false;
          }
          if (!result) {
            session.value.remove(cart.key);
          }
        }
      }
    }

    cleanCart();
    await saveCart(listCart);
    updateItemCount();
  }

  Future fetchData() async {
    RxMap<String, Map<String, RxMap<String, RxInt>>>? listData = getCart();
    if (listData != null) {
      listCart = listData;
    }
    logger.e('getCart - $listCart');
    await checkCartItem();
    logger.e('checkCartItem - $listCart');
    for (var profile in listCart.entries) {
      try {
        Profile profileData = await ProfileService().getById(profile.key);
        listProfile.putIfAbsent(profile.key, () => profileData);
      } catch (e) {
        //lỗi sẽ xóa dữ liệu trong cart
        listCart.remove(profile.key);
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
    updateTotal();
    updateItemCount();
    logger.e('getData end - $listCart');
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
      for (var cart in listCart.entries) {
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
      listCart.clear();
      await saveCart(listCart);
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
    listCart.forEach((profileId, listSession) {
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
    listCart.forEach((profileId, listSession) {
      listSession.forEach((sessionId, cart) {
        itemCount += cart.length;
      });
    });
  }

  void cleanCart() {
    if (listCart.values.isEmpty) {
      listCart.clear();
    } else {
      for (var profile in listCart.entries.toList()) {
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
          listCart.remove(profile.key);
          // return;
        }
      }
    }
  }

  Future<void> increaseItemCart(
      String profileId, String sessionId, String menuDetailId) async {
    if (listCart.containsKey(profileId)) {
      //if profileId đã có
      Map<String, Map<String, RxInt>> listSession = listCart[profileId]!;
      if (listSession.containsKey(sessionId)) {
        //sessionId đã có
        Map<String, RxInt> cart = listSession[sessionId]!;
        cart.update(menuDetailId, (value) => cart[menuDetailId]! + 1,
            ifAbsent: () => 1.obs);
      } else {
        //if sessionId chưa tồn tại
        listSession.putIfAbsent(sessionId, () => {menuDetailId: 1.obs});
      }
    } else {
      //profileId chưa tồn tại
      listCart.putIfAbsent(
          profileId,
          () => {
                sessionId: {menuDetailId: 1.obs}.obs
              });
    }
    await saveCart(listCart);
    updateItemCount();
    updateTotal();
  }

  Future<void> decreaseItemCart(
      String profileId, String sessionId, String menuDetailId) async {
    if (listCart.containsKey(profileId)) {
      //if profileId đã có
      Map<String, Map<String, RxInt>> listSession = listCart[profileId]!;
      if (listSession.containsKey(sessionId)) {
        //sessionId đã có
        Map<String, RxInt> cart = listSession[sessionId]!;
        if (cart.containsKey(menuDetailId)) {
          cart.update(menuDetailId, (value) => cart[menuDetailId]! - 1);
          //remove
          if (cart[menuDetailId]!.value == 0) {
            cart.remove(menuDetailId);
            cleanCart();
          }
        } else {
          //if menuDetailId chưa tồn tại
          return;
        }
      } else {
        //if sessionId chưa tồn tại
        return;
      }
    } else {
      //profileId chưa tồn tại
      return;
    }
    await saveCart(listCart);
    updateItemCount();
    updateTotal();
  }

  Future<void> deleteItemFromCart(
      String profileId, String sessionId, String menuDetailId) async {
    if (listCart.containsKey(profileId)) {
      // If profileId exists
      Map<String, Map<String, RxInt>> listSession = listCart[profileId]!;
      if (listSession.containsKey(sessionId)) {
        // If sessionId exists
        Map<String, RxInt> cart = listSession[sessionId]!;
        if (cart.containsKey(menuDetailId)) {
          // If menuDetailId exists, remove it
          cart.remove(menuDetailId);
          cleanCart();
        } else {
          // If menuDetailId does not exist
          return;
        }
      } else {
        // If sessionId does not exist
        return;
      }
    } else {
      // If profileId does not exist
      return;
    }
    await saveCart(listCart);
    updateItemCount();
    updateTotal();
  }

  bool ifAbsent(String profileId, String sessionId, String menuDetailId) {
    if (listCart.containsKey(profileId)) {
      if (listCart[profileId]!.containsKey(sessionId)) {
        return listCart[profileId]![sessionId]!.containsKey(menuDetailId);
      }
    }
    return false;
  }
}
