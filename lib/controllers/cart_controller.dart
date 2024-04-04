import 'package:get/get.dart';

import '/models/session.dart';
import '/models/menu_detail.dart';
import '/models/profile.dart';
import '/services/session_service.dart';
import '/services/profile_service.dart';

class CartController extends GetxController {
  RxInt itemCount = 0.obs;
  RxDouble total = RxDouble(0);
  Map<String, Profile> listProfile = <String, Profile>{};
  Map<String, Session> listSession = <String, Session>{};
  Map<String, MenuDetail> listMenuDetail = <String, MenuDetail>{};
  RxMap<String, Map<String, RxMap<String, RxInt>>> listCart =
      <String, Map<String, RxMap<String, RxInt>>>{}.obs;

  Future getData() async {
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

  void updateTotal() {
    total.value = 0;
    listCart.forEach((profileId, listSession) {
      listSession.forEach((sessionId, cart) {
        cart.forEach((key, value) {
          if (listMenuDetail[key] != null) {
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

  void increaseItemCart(
      String profileId, String sessionId, String menuDetailId) {
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
