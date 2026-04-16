import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/date_time_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';

class RecentOrdersSection extends StatelessWidget {
  const RecentOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'Đơn hàng gần đây',
              style: context.textTheme.bodyLarge,
            ),
            GestureDetector(
              onTap: () => context.go(AppRouter.order),
              child: const Text('Xem tất cả'),
            ),
          ],
        ),

        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is LoadingOrderHistory) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is OrderError) {
              return Center(child: Text(state.message));
            }

            if (state is LoadOrderHistorySuccess) {
              final orders = state.orders.take(4).toList();
              return ListView.separated(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    padding: const .all(16),
                    decoration: BoxDecoration(
                      borderRadius: .circular(12),
                      border: .all(
                        color: context.colors.outline,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              '#${order.orderNumber}',
                              style: context
                                  .textTheme
                                  .titleLarge,
                            ),
                            buildOrderStatus(
                              context,
                              order.status,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text('${order.totalItems} món'),
                            Text(
                              order.totalPrice.toVND(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(order.createdAt.fullTimeDate),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 16),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Container buildOrderStatus(
      BuildContext context,
      OrderStatus status,
      ) {
    late Color backgroundColor;
    late Color textColor;

    switch (status) {
      case .confirmed:
      case .preparing:
      case .completed:
        backgroundColor = context.colors.outlineVariant;
        textColor = context.colors.primary;
      case .cancelled:
        backgroundColor = context.colors.errorContainer;
        textColor = context.colors.error;
    }
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label,
        style: context.textTheme.bodyMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
