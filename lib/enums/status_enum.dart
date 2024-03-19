enum Status {
  active(1, 'Đang hoạt động'),
  blue(2, 'ngừng hoạt động'),
  delete(0, 'Đã xóa');

  const Status(this.code, this.message);

  final int code;
  final String message;
}

enum OrderStatus {
  preparing(1, 'Chờ chuẩn bị'),
  delivering(2, 'Chờ giao hàng'),
  completed(3, 'Đã giao'),
  cancelled(4, 'Đã hủy');

  const OrderStatus(this.code, this.message);

  final int code;
  final String message;

  static OrderStatus fromInt(int code) {
    switch (code) {
      case 1:
        return OrderStatus.preparing;
      case 2:
        return OrderStatus.delivering;
      case 3:
        return OrderStatus.completed;
      case 4:
        return OrderStatus.cancelled;
      default:
        return OrderStatus.preparing;
    }
  }
}
