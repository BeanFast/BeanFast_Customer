import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowInfoItemWidget extends StatelessWidget {
  const RowInfoItemWidget({super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              child: Text(
            title,
            style: Get.theme.textTheme.bodyLarge!.copyWith(
              color: Colors.black54,
            ),
          )),
          Expanded(
            child: Text(data,
                textAlign: TextAlign.right,
                style: Get.theme.textTheme.bodyLarge),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
