import 'package:flutter/material.dart';

import '/enums/status_enum.dart';

class BannerOrderStatus extends StatelessWidget {
  final OrderStatus status;
  const BannerOrderStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    switch (status) {
      case OrderStatus.preparing:
        color = Colors.grey[300]!;
        break;
      case OrderStatus.delivering:
        color = Colors.grey[300]!;
        break;
      case OrderStatus.completed:
        color = Colors.green;
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        break;
      default:
        color = Colors.black;
    }

    return Container(
      color: const Color.fromARGB(255, 106, 180, 108),
      // height: 40,
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10, top: 20),
      child: const Align(
        alignment: Alignment.centerLeft,
          child: Text('Đang chuẩn bị hàng',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ))),
    );
  }
}
