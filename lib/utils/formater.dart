import 'package:intl/intl.dart';

class Formater {
  static String formatMoney(String value) {
    String result = value.split('.')[0];
    final f = NumberFormat("#,###", "vi_VN");
    int num = int.parse(result.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = '${f.format(num)}đ';
    return newString;
  }
}
