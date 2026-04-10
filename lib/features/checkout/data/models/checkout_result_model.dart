import 'package:orda/core/enum/order_status.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';

class CheckoutResultModel extends CheckoutResult {
  const CheckoutResultModel({
    required super.orderNumber,
    required super.orderId,
    required super.createdAt,
    required super.status,
  });

  factory CheckoutResultModel.fromJson(JsonData json) {
    return CheckoutResultModel(
      orderNumber: json['order_number'] as int,
      orderId: json['order_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: OrderStatus.fromString(json['status'] as String),
    );
  }
}
