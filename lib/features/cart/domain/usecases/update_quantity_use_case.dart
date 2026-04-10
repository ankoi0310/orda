import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/cart/domain/repositories/cart_repository.dart';

class UpdateQuantityUseCase
    implements UseCase<void, UpdateQuantityParams> {
  const UpdateQuantityUseCase({required this.repository});

  final CartRepository repository;

  @override
  ResultFuture<void> call(UpdateQuantityParams params) async {
    final cartResult = await repository.getCart();

    return cartResult.flatMap((cart) async {
      final updatedCart = _updateCartLogic(cart, params);
      return repository.saveCart(updatedCart);
    });
  }

  Cart _updateCartLogic(Cart cart, UpdateQuantityParams params) {
    final index = cart.items.indexWhere(
      (e) => e.menuItem.id == params.menuItemId,
    );

    if (index == -1) {
      if (params.quantity > 0) {
        return cart.addItem(params.toCartItem());
      }
      return cart;
    }

    if (params.quantity == 0) {
      return cart.removeItem(params.productId);
    }

    return cart.updateItem(params.productId, params.quantity);
  }
}

class UpdateQuantityParams {
  const UpdateQuantityParams({
    required this.menuItemId,
    required this.quantity,
  });

  final String menuItemId;
  final int quantity; // +1 để tăng, -1 để giảm
}
