import 'package:fpdart/fpdart.dart' hide Order;
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/order/data/datasources/order_remote_data_source.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl({required this.remoteDataSource});

  final OrderRemoteDataSource remoteDataSource;

  @override
  ResultFuture<Order> getOrder({required String id}) async {
    try {
      final order = await remoteDataSource.getOrder(id: id);
      return right(order);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<List<Order>> getOrders({
    DateTime? from,
    DateTime? to,
    List<String>? statuses,
  }) async {
    try {
      final orders = await remoteDataSource.getOrders();
      return right(orders);
    } on ServerException catch (e) {
      return left(ValidationFailure(e.message));
    }
  }
}
