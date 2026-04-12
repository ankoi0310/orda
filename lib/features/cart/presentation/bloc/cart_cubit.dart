import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem(CartItem item) {
    emit(state.copyWith(status: CartStatus.updating));

    final items = [...state.items];
    final idx = items.indexWhere(
      (e) => e.menuItemId == item.menuItemId,
    );
    if (idx >= 0) {
      items[idx] = items[idx].copyWith(
        quantity: items[idx].quantity + 1,
      );
    } else {
      items.add(item);
    }
    emit(state.copyWith(status: CartStatus.updated, items: items));
  }

  void removeItem(String menuItemId) {
    emit(state.copyWith(status: CartStatus.updating));
    final items = state.items
        .where((e) => e.menuItemId != menuItemId)
        .toList();
    emit(
      items.isEmpty
          ? const CartState()
          : state.copyWith(status: CartStatus.updated, items: items),
    );
  }

  void updateQty(String menuItemId, int qty) {
    if (qty <= 0) return removeItem(menuItemId);

    emit(state.copyWith(status: CartStatus.updating));
    final items = state.items
        .map(
          (e) => e.menuItemId == menuItemId
              ? e.copyWith(quantity: qty)
              : e,
        )
        .toList();
    emit(state.copyWith(status: CartStatus.updated, items: items));
  }
}
