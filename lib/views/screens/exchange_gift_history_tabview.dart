import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/controllers/exchange_gift_controller.dart';
import '/models/exchange_gift.dart';
import '/views/screens/data_screen.dart';
import '/views/widgets/exchange_gift_item_widget.dart';
import '/enums/status_enum.dart';

class ExchangeGiftHistoryTabBarView extends GetView<ExchangeGiftController> {
  final ExchangeGiftStatus exchangeGiftStatus;

  const ExchangeGiftHistoryTabBarView(
      {super.key, required this.exchangeGiftStatus});
  @override
  Widget build(BuildContext context) {
    controller.orderStatus = exchangeGiftStatus;
    controller.resetExchangeGiftPagingController();
    return PagedListView<int, ExchangeGift>(
      pagingController: controller.pagingExchangeGiftController,
      builderDelegate: PagedChildBuilderDelegate<ExchangeGift>(
        itemBuilder: (context, item, index) {
          return ExchangeGiftItem(exchangeGift: item);
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
