import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_item_list_view.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_promo.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xác nhận đơn hàng')),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            CheckoutItemListView(items: fakeCartItems),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CheckoutPromo(),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 8,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tạm tính',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        40000.toVND(),
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Khuyến mãi',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        '-${0.toVND()}',
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền',
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    50000.toVND(),
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: () =>
                    context.push('${AppRouter.checkout}/success'),
                child: const Text('Đặt hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
