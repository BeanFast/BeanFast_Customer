import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/order.dart';
import '/contrains/theme_color.dart';
import '/enums/status_enum.dart';

class BannerOrderStatus extends StatelessWidget {
  final Order order;
  const BannerOrderStatus({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    OrderStatus status = OrderStatus.fromInt(order.status!);
    Color color = ThemeColor.bgColor;
    Text text = const Text('');
    switch (status) {
      case OrderStatus.preparing:
        // color = Colors.grey[300]!;
        text = const Text('Đang chuẩn bị hàng',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
        break;
      case OrderStatus.delivering:
        // color = Colors.grey[300]!;
        text = Text(
          'Đơn hàng sẽ được giao vào lúc ${DateFormat('hh:mm').format(order.sessionDetail!.session!.deliveryStartTime!)} đến ${DateFormat('hh:mm dd/MM/yy').format(order.sessionDetail!.session!.deliveryEndTime!)}. Vui lòng kiểm tra trước khi nhận hàng',
          style: const TextStyle(
            color: Colors.white,
          ),
        );
        break;
      case OrderStatus.completed:
        text = const Text(
          'Cảm ơn bạn chọn BeanFast!',
          style: TextStyle(
            color: Colors.white,
          ),
        );
        break;
      case OrderStatus.cancelled:
        text = const Text(
          'Đơn hàng đã bị huỷ. Vui lòng liên hệ với chúng tôi để biết thêm chi tiết.',
          style: TextStyle(
            color: Colors.white,
          ),
        );
        break;
      default:
        color = Colors.black;
    }

    return Container(
      color: const Color.fromARGB(255, 106, 180, 108),
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: text,
          ),
          const SizedBox(
            width: 90,
            child: Icon(
              Icons.car_rental,
              color: Colors.white,
              size: 90,
            ),
          )
        ],
      ),
    );
  }
}
