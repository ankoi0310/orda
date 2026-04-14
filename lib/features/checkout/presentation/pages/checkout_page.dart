import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:orda/features/checkout/domain/entities/payment_method.dart';
import 'package:orda/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_item_list_view.dart';
import 'package:orda/features/checkout/presentation/widgets/checkout_promo_widget.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) async {
        if (state is CheckoutSuccess) {
          await context.push('${AppRouter.checkout}/success');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Thông tin đặt hàng')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: cartState.items.isNotEmpty
                        ? const CheckoutItemListView()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
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
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = context.pop,
                                      ),
                                    ],
                                    style:
                                        context.textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Divider(
                    thickness: 8,
                    color: context.colors.outline,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CheckoutPromoWidget(),
                  ),
                  Divider(
                    thickness: 8,
                    color: context.colors.outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      spacing: 16,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'Thông tin thanh toán',
                              style: context.textTheme.bodyLarge,
                            ),
                            Text(
                              'Xem tất cả',
                              textAlign: .end,
                              style: TextStyle(
                                color:
                                    context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Iconsax.card_pos_copy),
                            const SizedBox(width: 16),
                            Text(PaymentMethod.cash.label),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 8,
                    color: context.colors.outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      spacing: 8,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tạm tính',
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              cartState.total.toVND(),
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng tiền',
                          style: context.textTheme.bodyLarge,
                        ),
                        Text(
                          cartState.total.toVND(),
                          style: context.textTheme.bodyLarge,
                        ),
                      ],
                    ),
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
                    onPressed: cartState.items.isEmpty
                        ? null
                        : () => context
                              .read<CheckoutCubit>()
                              .confirmCash(cartState.items),
                    child: const Text('Xác nhận đặt hàng'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
