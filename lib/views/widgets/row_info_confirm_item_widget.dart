import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowInforWidget extends StatelessWidget {
  const RowInforWidget({super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            child: Text(
          title,
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black54),
        )),
        Expanded(
          child: Text(data,
              textAlign: TextAlign.right, style: Get.textTheme.bodyLarge),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}