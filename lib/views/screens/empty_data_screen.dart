import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyDataScreen extends StatelessWidget {
  final String message;
  const EmptyDataScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              "assets/images/order_image.png",
            ),
          ),
          Text(
            message,
            style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
