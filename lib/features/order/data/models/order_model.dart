import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/order/data/models/order_item_model.dart';
import 'package:orda/features/order/domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.shopId,
    required super.orderNumber,
    required super.note,
    required super.totalPrice,
    required super.status,
    required super.createdAt,
    required super.items,
  });

  factory OrderModel.fromJson(JsonData json) {
    return OrderModel(
      id: json['id'] as String,
      shopId: json['shop_id'] as String,
      orderNumber: json['order_number'] as int,
      note: json['note'] as String,
      totalPrice: json['total_price'] as int,
      status: _parseStatus(json['status'] as String),
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ).toLocal(),
      items: json['order_items'] == null
          ? []
          : List<JsonData>.from(
              json['order_items'] as List,
            ).map(OrderItemModel.fromJson).toList(),
    );
  }

  static OrderStatus _parseStatus(String s) => switch (s) {
    'confirmed' => OrderStatus.confirmed,
    'preparing' => OrderStatus.preparing,
    'completed' => OrderStatus.completed,
    _ => OrderStatus.cancelled,
  };
}
