import 'package:get/get.dart';

import '/contains/theme_color.dart';

class DialogUtils {
  static Future showConfirmationDialog({
    required String title,
    required String content,
    required String textConfirm,
    required String textCancel,
    required Future Function() onConfirm,
  }) async {
    Get.defaultDialog(
      title: title,
      middleText: content,
      textConfirm: textConfirm,
      textCancel: textCancel,
      confirmTextColor: ThemeColor.itemColor,
      buttonColor: ThemeColor.iconColor,
      cancelTextColor: ThemeColor.iconColor,
      onConfirm: () async {
        Get.back();
        await onConfirm();
      },
      onCancel: () {},
    );
  }

  // static Future showConfirmationDialog({
  //   required String title,
  //   required String content,
  //   required String textConfirm,
  //   required String textCancel,
  //   required Future Function() onConfirm,
  // }) async {
  //   Get.dialog(
  //     AlertDialog(
  //       title: Text(title, style: Get.textTheme.titleSmall),
  //       content: Text(content),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Get.back();
  //           },
  //           child: Text(textCancel, style: Get.textTheme.bodySmall),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             Get.back();
  //             await onConfirm();
  //           },
  //           child: Text(textConfirm, style: Get.textTheme.bodySmall),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
