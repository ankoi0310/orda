import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/cart/data/models/cart_item_model.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<SetShop>(_onSetShop);
    on<AddToCart>(_onAddToCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onSetShop(
    SetShop event,
    Emitter<CartState> emit,
  ) async {
    if (state.shopId != null && state.shopId != event.shopId) {
      emit(const CartState()); // clear cart
    }

    emit(state.copyWith(shopId: event.shopId));
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    final items = List<CartItem>.from(state.items);

    final index = items.indexWhere(
      (e) => e.menuItem.id == event.item.id,
    );

    if (index != -1) {
      final existing = items[index];
      items[index] = existing.copyWith(
        quantity: existing.quantity + 1,
      );
    } else {
      items.add(CartItem(menuItem: event.item, quantity: 1));
    }

    emit(
      state.copyWith(
        items: items,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    final items = List<CartItem>.from(state.items);

    final index = items.indexWhere(
      (e) => e.menuItem.id == event.itemId,
    );

    if (index == -1) return;

    final item = items[index];

    items[index] = item.copyWith(quantity: item.quantity + 1);

    emit(
      state.copyWith(
        items: items,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    final items = List<CartItem>.from(state.items);

    final index = items.indexWhere(
      (e) => e.menuItem.id == event.itemId,
    );

    if (index == -1) return;

    final item = items[index];

    if (item.quantity > 1) {
      items[index] = item.copyWith(quantity: item.quantity - 1);
    } else {
      items.removeAt(index);
    }

    emit(
      state.copyWith(
        items: items,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    final items = List<CartItem>.from(state.items)
      ..removeWhere((e) => e.menuItem.id == event.itemId);

    emit(
      state.copyWith(
        items: items,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) async {
    emit(const CartState());
  }

  @override
  CartState? fromJson(JsonData json) {
    final state = CartState.fromJson(json);

    if (state.updatedAt == null) return state;

    final now = DateTime.now().millisecondsSinceEpoch;

    const timeout = 30 * 60 * 1000;

    if (now - state.updatedAt! > timeout) {
      return const CartState(); // expired
    }

    return state;
  }

  @override
  JsonData? toJson(CartState state) {
    return state.toJson();
  }
}
