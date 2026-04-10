import 'package:equatable/equatable.dart';
import 'package:orda/features/order/domain/entities/order_item.dart';

class Order extends Equatable {
  const Order({required this.id, required this.items});

  final String id;
  final List<OrderItem> items;

  @override
  List<Object?> get props => [id, items];
}
