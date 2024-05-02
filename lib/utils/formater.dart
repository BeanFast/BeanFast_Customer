import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:get/get.dart';

class Formater {
  static String formatMoney(String value) {
    String result = value.split('.')[0];
    final f = NumberFormat("#,###", "vi_VN");
    int num = int.parse(result.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = '${f.format(num)} đ';
    return newString;
  }

  static String formatPoint(String value) {
    String result = value.split('.')[0];
    final f = NumberFormat("#,###", "vi_VN");
    int num = int.parse(result.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = '${f.format(num)} điểm';
    return newString;
  }

  static String rxMapToJson(
      Map<String, Map<String, RxMap<String, RxInt>>> rxMap) {
    Map<String, dynamic> jsonMap = {};
    rxMap.forEach((key, value) {
      Map<String, dynamic> innerMap = {};
      value.forEach((innerKey, innerValue) {
        Map<String, int> innerInnerMap = {};
        innerValue.forEach((innerInnerKey, innerInnerValue) {
          innerInnerMap[innerInnerKey] = innerInnerValue.value;
        });
        innerMap[innerKey] = innerInnerMap;
      });
      jsonMap[key] = innerMap;
    });
    return json.encode(jsonMap);
  }

  static RxMap<String, Map<String, RxMap<String, RxInt>>> jsonToRxMap(
      String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final rxMap = RxMap<String, Map<String, RxMap<String, RxInt>>>({});

    jsonMap.forEach((key, value) {
      final Map<String, RxMap<String, RxInt>> innerMap = {};

      (value as Map).forEach((innerKey, innerValue) {
        final Map<String, RxInt> innerInnerMap = {};

        (innerValue as Map).forEach((innerInnerKey, innerInnerValue) {
          innerInnerMap[innerInnerKey] = RxInt(innerInnerValue);
        });

        innerMap[innerKey] = RxMap(innerInnerMap);
      });

      rxMap[key] = innerMap;
    });

    return rxMap;
  }
}
