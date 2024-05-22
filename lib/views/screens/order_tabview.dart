import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/order.dart';
import 'data_screen.dart';
import '/controllers/order_controller.dart';
import '/enums/status_enum.dart';
import '/views/widgets/order_item_widget.dart';

class OrderTabBarView extends GetView<OrderController> {
  final OrderStatus orderStatus;

  const OrderTabBarView({super.key, required this.orderStatus});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.orderStatus = orderStatus;
    controller.resetPagingController();
    return PagedListView<int, Order>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Order>(
        itemBuilder: (context, item, index) {
          return OrderItem(order: item);
        },
        noItemsFoundIndicatorBuilder: (context) => const DataScreen(
          hasData: false,
          message: 'Chưa có đơn hàng',
          child: Center(),
        ),
        firstPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Lỗi tải trang'),
        ),
        newPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Lỗi tải trang mới'),
        ),
      ),
    );
  }
}
