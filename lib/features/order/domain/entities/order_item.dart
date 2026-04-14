import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  const OrderItem({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String orderId;
  final String menuItemId;
  final String name;
  final int price;
  final int quantity;

  @override
  List<Object?> get props => [
    id,
    orderId,
    menuItemId,
    name,
    price,
    quantity,
  ];
}
