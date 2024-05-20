import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants.dart';
import 'formater.dart';

mixin CacheManager {
  final box = GetStorage();
  Future<bool> saveToken(String? token) async {
    await box.write(CacheManagerKey.CUSTOMERTOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    return box.read(CacheManagerKey.CUSTOMERTOKEN.toString());
  }

  Future<void> removeToken() async {
    await box.remove(CacheManagerKey.CUSTOMERTOKEN.toString());
  }

  Future<bool> saveCart(
      Map<String, Map<String, RxMap<String, RxInt>>> cart) async {
    String json = Formater.rxMapToJson(cart);
    await box.write(
        CacheManagerKey.CART.toString() + currentUser.value!.phone.toString(),
        json);
    return true;
  }

  RxMap<String, Map<String, RxMap<String, RxInt>>>? getCart() {
    String? json = box.read(
        CacheManagerKey.CART.toString() + currentUser.value!.phone.toString());
    return json == null ? null : Formater.jsonToRxMap(json);
  }

  Future<void> removeCart() async {
    await box.remove(
        CacheManagerKey.CART.toString() + currentUser.value!.phone.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { CUSTOMERTOKEN, CART }