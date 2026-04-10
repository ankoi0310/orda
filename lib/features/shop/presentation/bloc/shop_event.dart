part of 'shop_bloc.dart';

sealed class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

final class LoadShop extends ShopEvent {
  const LoadShop({required this.shopId});

  final String? shopId;

  @override
  List<Object?> get props => [shopId];
}
