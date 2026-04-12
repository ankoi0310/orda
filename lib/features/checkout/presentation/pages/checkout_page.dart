import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_item_list_view.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_promo_widget.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Xác nhận đơn hàng')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            spacing: 20,
            children: [
              if (state.items.isNotEmpty)
                const CheckoutItemListView()
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    spacing: 8,
                    children: [
                      const Icon(
                        Iconsax.clipboard_close_copy,
                        size: 32,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Giỏ hàng đang trống. ',
                            ),
                            TextSpan(
                              text: 'Đặt món ngay',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = context.pop,
                            ),
                          ],
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              const CheckoutPromoWidget(),
              const Divider(),
              Column(
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
                        state.total.toVND(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền',
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    state.total.toVND(),
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
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
                onPressed: state.items.isEmpty
                    ? null
                    : () => context.push(
                        '${AppRouter.checkout}/success',
                      ),
                child: const Text('Xác nhận đặt hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
