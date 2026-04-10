import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/core/utils/typedefs.dart';

abstract class OrderRepository {
  ResultFuture<List<Order>> getOrderList({
    DateTime? from,
    DateTime? to,
    List<String>? statuses,
  });

  ResultFuture<Order> getOrder({required String id});
}
