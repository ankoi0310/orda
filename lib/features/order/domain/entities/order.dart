import 'package:equatable/equatable.dart';
import 'package:orda/features/order/domain/entities/order_item.dart';

enum OrderStatus {
  confirmed('Đã xác nhận'),
  preparing('Đang chuẩn bị'),
  completed('Hoàn thành'),
  cancelled('Đã hủy');

  const OrderStatus(this.label);

  final String label;
}

class Order extends Equatable {
  const Order({
    required this.id,
    required this.shopId,
    required this.orderNumber,
    required this.note,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  final String id;
  final String shopId;
  final int orderNumber;
  final String note;
  final int totalPrice;
  final OrderStatus status;
  final DateTime createdAt;
  final List<OrderItem> items;

  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [
    id,
    shopId,
    orderNumber,
    note,
    totalPrice,
    status,
    createdAt,
    items,
  ];
}
