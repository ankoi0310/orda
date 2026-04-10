import 'package:orda/core/error/exceptions.dart';
import 'package:orda/features/cart/data/models/cart_model.dart';

abstract class CartLocalDataSource {
  CartModel getCart();

  void saveCart(CartModel cart);

  void clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartModel? _inMemoryCart;

  @override
  CartModel getCart() {
    if (_inMemoryCart == null) {
      throw const CacheException('Không thể truy cập bộ nhớ RAM');
    }

    return _inMemoryCart!;
  }

  @override
  void saveCart(CartModel cart) {
    if (_inMemoryCart == null) {
      _inMemoryCart = cart;
      return;
    }

    // if (_inMemoryCart!.shopId != cart.shopId) {
    //   _inMemoryCart!.copyWith(shopId: cart.shopId, items: cart.items);
    // }

    _inMemoryCart!.copyWith(shopId: cart.shopId, items: cart.items);
  }

  @override
  void clearCart() {
    _inMemoryCart = null;
  }
}
