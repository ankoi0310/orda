import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:orda/features/cart/data/models/cart_model.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl({required this.localDataSource});

  final CartLocalDataSource localDataSource;

  @override
  ResultFuture<Cart> getCart() async {
    try {
      final cart = localDataSource.getCart();
      return Right(cart); // Trả về kết quả thành công
    } on CacheException catch (e){
      return Left(
        ValidationFailure(e.message),
      );
    } catch (e) {
      return Left(ValidationFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  ResultFuture<Cart<CartItem>> saveCart(Cart<CartItem> cart) async {
    // TODO: implement saveCart
    throw UnimplementedError();
  }

  @override
  VoidFuture clearCart() async {
    try {
      localDataSource.clearCart();
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
