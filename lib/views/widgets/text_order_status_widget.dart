import 'package:flutter/material.dart';

import '/enums/status_enum.dart';

class TextOrderStatus extends StatelessWidget {
  final OrderStatus status;
  const TextOrderStatus({super.key, required this.status});

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

    return Text(status.message,
        style:
            TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold));
  }
}
