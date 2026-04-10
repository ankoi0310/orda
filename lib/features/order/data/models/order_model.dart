import 'package:orda/features/order/data/models/order_item_model.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/core/utils/typedefs.dart';

class OrderModel extends Order {
  const OrderModel({required super.id, required super.items});

  factory OrderModel.fromJson(JsonData json) {
    return OrderModel(
      id: json['id'] as String,
      items: List.of(
        json['items'] as List<JsonData>,
      ).map(OrderItemModel.fromJson).toList(),
    );
  }
}
