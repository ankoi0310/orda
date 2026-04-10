part of 'shop_bloc.dart';

sealed class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

final class ShopInitial extends ShopState {}

final class ShopLoading extends ShopState {}

final class ShopLoaded extends ShopState {
  const ShopLoaded(this.shop);

  final Shop shop;

  @override
  List<Object> get props => [shop];
}

final class ShopError extends ShopState {
  const ShopError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
