import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '/enums/menu_index_enum.dart';
import '/models/location.dart';
import '/models/school.dart';
import '/services/order_service.dart';
import '/utils/constants.dart';
import '/utils/logger.dart';
import '/services/school_service.dart';
import '/views/screens/splash_screen.dart';
import '/models/session.dart';
import '/models/menu_detail.dart';
import '/models/profile.dart';
import '/services/session_service.dart';
import '/services/profile_service.dart';
import 'auth_controller.dart';

class CartController extends GetxController with CacheManager {
  RxInt itemCount = 0.obs;
  RxDouble total = RxDouble(0);
  double totalPrice = 0;
  Map<String, Profile> listProfile = <String, Profile>{}; // key: profileId
  Map<String, Session> listSession = <String, Session>{}; // key: sessionId
  Map<String, Location> listLocation = <String, Location>{}; // key: locationId
  Map<String, MenuDetail> listMenuDetail = <String, MenuDetail>{};
  Map<String, String> listSessionDetailId =
      <String, String>{}; // key: sessionId, value: sessionDetailId
  RxMap<String, Map<String, RxMap<String, RxInt>>> listCart =
      <String, Map<String, RxMap<String, RxInt>>>{}.obs;

  Future getData() async {
    Map<String, Map<String, RxMap<String, RxInt>>>? listData = getCart();
    logger.e('getCart - $listData');
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
  }

  Future getLocationsData() async {
    try {
      for (var cart in listCart.entries) {
        School school = await SchoolService()
            .getById(listProfile[cart.key]!.school!.id.toString());
        school.locations?.forEach((e) {
          listLocation.putIfAbsent(e.id!, () => e);
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateSessionDetai(String sessionId, String sessionDetailId) {
    listSessionDetailId.update(
      sessionId,
      (value) => sessionDetailId,
      ifAbsent: () => sessionDetailId,
    );
  }

  Future<bool> checkout() async {
    try {
      for (var cart in listCart.entries) {
        for (var session in cart.value.entries) {
          Map<String, int> map = {};
          for (var menuDetail in session.value.entries) {
            map[menuDetail.key] = menuDetail.value.value;
          }
          await OrderService()
              .create(listSessionDetailId[session.key]!, cart.key, map);
        }
      }
      listCart.clear();
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
            totalPrice += listMenuDetail[key]!.food!.price!;
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
    updateItemCount();
    updateTotal();
  }

  void decreaseItemCart(
      String profileId, String sessionId, String menuDetailId) {
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
