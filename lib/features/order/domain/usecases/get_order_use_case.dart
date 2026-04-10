import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/domain/repositories/order_repository.dart';

class GetOrderDetailUseCase implements UseCase<Order, String> {
  const GetOrderDetailUseCase({required this.repository});

  final OrderRepository repository;

  @override
  ResultFuture<Order> call(String id) async {
    return repository.getOrder(id: id);
  }
}
