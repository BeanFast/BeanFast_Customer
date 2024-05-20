import 'package:beanfast_customer/views/widgets/sbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contains/theme_color.dart';

class ResultScreenWidget extends StatelessWidget {
  final bool isSuccess;
  final String content;
  final String ontapNameLeftSide;
  final VoidCallback ontapLeftSide;
  final String ontapNameRightSide;
  final VoidCallback ontapRightSide;

  const ResultScreenWidget({
    super.key,
    required this.isSuccess,
    required this.content,
    required this.ontapLeftSide,
    required this.ontapRightSide,
    required this.ontapNameLeftSide,
    required this.ontapNameRightSide,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: isSuccess ? ThemeColor.primaryColor : Colors.white,
      // ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: isSuccess ? ThemeColor.primaryColor : Colors.white,
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isSuccess
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 2),
                      Text('Đặt hàng thành công',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.titleMedium!.copyWith()),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cancel,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        textAlign: TextAlign.center,
                        'Đặt hàng thất bại',
                        style: Get.textTheme.titleMedium!.copyWith(),
                      ),
                    ],
                  ),
            const SizedBox(height: 10),
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              content,
              style: Get.textTheme.bodySmall!.copyWith(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2 - 30,
                  child: SButton(
                      color: isSuccess ? ThemeColor.primaryColor : Colors.white,
                      borderColor: Colors.black,
                      text: ontapNameLeftSide,
                      textStyle: Get.textTheme.titleMedium!
                          .copyWith(color: Colors.black),
                      onPressed: ontapLeftSide),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: Get.width / 2 - 30,
                  child: SButton(
                      color: isSuccess ? ThemeColor.primaryColor : Colors.white,
                      borderColor: Colors.black,
                      text: ontapNameRightSide,
                      textStyle: Get.textTheme.titleMedium!
                          .copyWith(color: Colors.black),
                      onPressed: ontapRightSide),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
