import 'package:equatable/equatable.dart';
import 'package:orda/features/shop/domain/entities/menu_item.dart';

class MenuCategory extends Equatable {
  const MenuCategory({
    required this.id,
    required this.name,
    required this.items,
  });

  factory MenuCategory.test({
    String? id,
    String? name,
    List<MenuItem>? items,
  }) {
    return MenuCategory(
      id: id ?? 'category_123',
      name: name ?? 'Appetizers',
      items: items ?? menuItems,
    );
  }

  final String id;
  final String name;
  final List<MenuItem> items;

  @override
  List<Object?> get props => [id, name, items];
}

final List<MenuCategory> fakeCategories = [
  MenuCategory.test(id: 'category_1', name: 'Trà sữa'),
  MenuCategory.test(id: 'category_2', name: 'Cà phê'),
  MenuCategory.test(id: 'category_3', name: 'Ăn vặt'),
];
