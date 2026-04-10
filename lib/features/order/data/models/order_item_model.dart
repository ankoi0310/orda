import 'package:orda/features/order/domain/entities/order_item.dart';
import 'package:orda/core/utils/typedefs.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({required super.id});

  factory OrderItemModel.fromJson(JsonData json) {
    return OrderItemModel(id: json['id'] as String);
  }
}
