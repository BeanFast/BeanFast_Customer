import 'package:intl/intl.dart';

class Formater {
  static String formatMoney(String value) {
    final f = NumberFormat("#,###", "vi_VN");
    int num = int.parse(value.replaceAll(f.symbols.GROUP_SEP, ''));
    final newString = '${f.format(num)}đ';
    return newString;
  }
}
