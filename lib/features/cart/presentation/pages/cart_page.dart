import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:orda/features/cart/presentation/widgets/item_quantity.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng của bạn')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CartItemCard(item: CartItem.test().menuItem),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(Iconsax.close_circle_copy),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 8,
                    child: ItemQuantity(item: CartItem.test()),
                  ),
                ],
              ),
              Center(
                child: TextButton(
                  onPressed: () => context.push(AppRouter.checkout),
                  child: Text('Check Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
