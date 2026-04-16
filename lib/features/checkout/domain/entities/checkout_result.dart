import 'package:equatable/equatable.dart';
import 'package:orda/features/order/domain/entities/order.dart';

class CheckoutResult extends Equatable {
  const CheckoutResult({
    required this.orderId,
    required this.orderNumber,
    required this.createdAt,
    required this.status,
  });

  final String orderId;
  final int orderNumber;
  final DateTime createdAt;
  final OrderStatus status;

  @override
  List<Object?> get props => [
    orderId,
    orderNumber,
    createdAt,
    status,
  ];
}
