import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';

abstract class CartRepository {
  ResultFuture<Cart> getCart();
  ResultFuture<Cart> saveCart(Cart cart);
  VoidFuture clearCart();
}
