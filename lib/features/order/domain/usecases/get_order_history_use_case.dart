import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/domain/repositories/order_repository.dart';

class GetOrderHistoryUseCase
    implements UseCase<List<Order>, OrderFilter> {
  const GetOrderHistoryUseCase({required this.repository});

  final OrderRepository repository;

  @override
  ResultFuture<List<Order>> call(OrderFilter params) async {
    return repository.getOrders(
      from: params.from,
      to: params.to,
      statuses: params.statuses,
    );
  }
}

class OrderFilter {
  const OrderFilter({this.from, this.to, this.statuses});

  final DateTime? from;
  final DateTime? to;
  final List<String>? statuses;
}
