part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.shopId,
    this.updatedAt,
  });

  /// 🔥 Deserialize (Model -> Entity)
  factory CartState.fromJson(JsonData json) {
    final itemsJson = (json['items'] as List?) ?? [];

    return CartState(
      items: itemsJson
          .map(
            (e) => CartItemModel.fromJson(e as JsonData).toEntity(),
          )
          .toList(),
      shopId: json['shop_id'] as String?,
      updatedAt: json['updated_at'] as int?,
    );
  }

  /// 🔥 Serialize (Entity -> Model)
  JsonData toJson() {
    return {
      'items': items.map((e) => CartItemModel.toJson(e)).toList(),
      'shop_id': shopId,
      'updated_at': updatedAt,
    };
  }

  CartState copyWith({
    List<CartItem>? items,
    String? shopId,
    int? updatedAt,
  }) {
    return CartState(
      items: items ?? this.items,
      shopId: shopId ?? this.shopId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  final List<CartItem> items;
  final String? shopId;
  final int? updatedAt;

  @override
  List<Object?> get props => [items, shopId, updatedAt];
}
