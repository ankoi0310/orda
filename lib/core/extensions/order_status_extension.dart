import 'package:orda/core/enum/order_status.dart';

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.confirmed:
        return 'Đã xác nhận';
      case OrderStatus.ready:
        return 'Đã sẵn sàng';
      case OrderStatus.completed:
        return 'Hoàn thành';
      case OrderStatus.cancelled:
        return 'Đã huỷ';
    }
  }
}
