import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/order/domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.menuItemId,
    required super.name,
    required super.price,
    required super.quantity,
  });

  factory OrderItemModel.fromJson(JsonData json) {
    return OrderItemModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      menuItemId: json['menu_item_id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
    );
  }
}
