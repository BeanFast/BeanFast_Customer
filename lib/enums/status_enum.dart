enum Status {
  active(1, 'Đang hoạt động'),
  blue(2, 'ngừng hoạt động'),
  delete(0, 'Đã xóa');

  const Status(this.code, this.message);

  final int code;
  final String message;
}

enum OrderStatus {
  preparing(3, 'Chờ chuẩn bị'),
  delivering(4, 'Chờ giao hàng'),
  completed(5, 'Hoàn thành'),
  cancelled(6, 'Đã hủy');

  const OrderStatus(this.code, this.message);

  final int code;
  final String message;

  static OrderStatus fromInt(int code) {
    switch (code) {
      case 3:
        return OrderStatus.preparing;
      case 4:
        return OrderStatus.delivering;
      case 5:
        return OrderStatus.completed;
      case 6:
        return OrderStatus.cancelled;
      default:
        return OrderStatus.preparing;
    }
  }
}
