import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  const MenuItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isAvailable,
  });

  factory MenuItem.test({
    String? id,
    String? categoryId,
    String? name,
    String? description,
    String? imageUrl,
    int? price,
    bool? isAvailable,
  }) {
    return MenuItem(
      id: id ?? 'item_123',
      categoryId: categoryId ?? 'category_123',
      name: name ?? 'Spring Rolls',
      description:
          description ?? 'Crispy spring rolls with vegetables.',
      imageUrl: imageUrl ?? 'https://example.com/spring_rolls.jpg',
      price: price ?? 20000,
      isAvailable: isAvailable ?? true,
    );
  }

  final String id;
  final String categoryId;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final bool isAvailable;

  @override
  List<Object?> get props => [
    id,
    categoryId,
    name,
    description,
    imageUrl,
    price,
    isAvailable,
  ];
}

final List<MenuItem> menuItems = [
  MenuItem.test(id: 'item_1', name: 'Spring Rolls'),
  MenuItem.test(id: 'item_2', name: 'Grilled Chicken'),
  MenuItem.test(id: 'item_3', name: 'Chocolate Cake'),
  MenuItem.test(id: 'item_4', name: 'Lemonade'),
  MenuItem.test(id: 'item_5', name: 'Caesar Salad'),
];
