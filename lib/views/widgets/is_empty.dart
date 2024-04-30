import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsEmptyWidget extends StatelessWidget {
  final String title;
  const IsEmptyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black54),
      ),
    );
  }
}
