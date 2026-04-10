import 'package:equatable/equatable.dart';
import 'package:orda/features/shop/domain/entities/menu_category.dart';

class Shop extends Equatable {
  const Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.categories,
  });

  factory Shop.test({
    String? id,
    String? name,
    String? description,
    String? address,
    String? imageUrl,
    List<MenuCategory>? categories,
  }) {
    return Shop(
      id: id ?? 'category_123',
      name: name ?? 'Appetizers',
      description: description ?? 'Mo ta',
      address: address ?? 'Dia chi cua quan',
      imageUrl:
          imageUrl ??
          'https://lzfesclzulylgfkqnhfy.supabase.co/storage/v1/object/public/images/default_shop.jpg',
      categories: categories ?? fakeCategories,
    );
  }

  final String id;
  final String name;
  final String description;
  final String address;
  final String imageUrl;
  final List<MenuCategory> categories;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    address,
    imageUrl,
    categories,
  ];
}
