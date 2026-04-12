import 'package:fpdart/fpdart.dart' hide Order;
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:orda/features/checkout/domain/entities/checkout_result.dart';
import 'package:orda/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:orda/features/checkout/domain/usecases/checkout_with_cash_use_case.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl({required this.remoteDataSource});

  final CheckoutRemoteDataSource remoteDataSource;

  @override
  ResultFuture<CheckoutResult> createOrder(
    CheckoutWithCashParams params,
  ) async {
    try {
      final checkoutResult = await remoteDataSource.createOrder(
        params,
      );
      return Right(checkoutResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Tạo đơn hàng không thành công: $e'));
    }
  }
}
