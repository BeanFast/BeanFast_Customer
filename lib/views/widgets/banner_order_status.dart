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
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Đang chuẩn bị hàng',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(
                  'Đơn hàng sẽ được chuẩn bị trước ngày 1/1/2024.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                // Text(
                //   'Đơn hàng sẽ được giao vào lúc 7h30 đến 8h ngày 1/1/2024. Vui lòng kiểm tra trước khi nhận hàng',
                //   style: TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
                // Text(
                //   'Cảm ơn bạn chọn BeanFast!',
                //   style: TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
                // Text(
                //   'Đơn hàng đã bị huỷ vào 7h30. Vui lòng liên hệ với chúng tôi để biết thêm chi tiết.',
                //   style: TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            width: 90,
            child: const Icon(
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
