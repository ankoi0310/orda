import 'package:fpdart/fpdart.dart';
import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/domain/entities/cart.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/cart/domain/repositories/cart_repository.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

class AddToCartUseCase implements UseCase<Cart, MenuItem> {
  const AddToCartUseCase({required this.repository});

  final CartRepository repository;

  @override
  ResultFuture<Cart> call(MenuItem params) async {
    // 🔥 Lấy cart hiện tại
    final result = await repository.getCart();

    return await result.fold((failure) async => Left(failure), (
      cart,
    ) async {
      final updatedCart = _updateCart(cart, params);

      return repository.saveCart(updatedCart);
    });
  }

  Cart _updateCart(Cart cart, MenuItem menuItem) {
    final index = cart.items.indexWhere(
      (e) => e.menuItem.id == menuItem.id,
    );

    // ❌ Chưa tồn tại
    if (index == -1) {
      return cart.copyWith(
        items: [
          ...cart.items,
          CartItem(menuItem: menuItem, quantity: 1),
        ],
      );
    }

    final existing = cart.items[index];

    // 🔄 update quantity
    final updatedItem = existing.copyWith(
      quantity: existing.quantity + 1,
    );

    final newItems = [...cart.items];
    newItems[index] = updatedItem;

    return cart.copyWith(items: newItems);
  }
}
