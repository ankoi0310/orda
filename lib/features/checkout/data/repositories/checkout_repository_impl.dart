import 'package:fpdart/fpdart.dart' hide Order;
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl({required this.remoteDataSource});

  final CheckoutRemoteDataSource remoteDataSource;

  @override
  ResultFuture<CheckoutResult> placeOrder({
    required Cart cart,
  }) async {
    try {
      final orderId = await remoteDataSource.createOrder(cart: cart);
      return right(orderId);
    } on ServerException catch (e) {
      return left(ValidationFailure(e.message));
    }
  }
}
