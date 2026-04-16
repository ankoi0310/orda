import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/date_time_extension.dart';
import 'package:orda/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:orda/features/order/domain/entities/order.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutSuccess) {
                final result = state.checkoutResult;

                return Column(
                  crossAxisAlignment: .stretch,
                  spacing: 8,
                  children: [
                    SizedBox(
                      height: context.height * 0.5,
                      child: Column(
                        mainAxisAlignment: .center,
                        spacing: 8,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Icon(Iconsax.bill_copy, size: 100),
                          ),
                          Text(
                            'Đặt hàng thành công',
                            style: context.textTheme.headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            width: context.width * .8,
                            child: Text(
                              'Cảm ơn bạn đã đặt hàng, '
                              'vui lòng chờ nhận theo số thứ tự được hiển thị',
                              textAlign: .center,
                              style: context.textTheme.titleMedium!
                                  .copyWith(
                                    color: context.colors.primary
                                        .withValues(alpha: .5),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: .stretch,
                      spacing: 8,
                      children: [
                        Text(
                          'Chi tiết đơn hàng',
                          style: context.textTheme.titleLarge,
                        ),
                        Container(
                          padding: const .all(16),
                          decoration: BoxDecoration(
                            borderRadius: .circular(16),
                            border: .all(
                              color: context.colors.outline,
                            ),
                          ),
                          child: Column(
                            spacing: 16,
                            children: [
                              buildRow(
                                context,
                                title: 'Thứ tự đơn hàng',
                                content: '${result.orderNumber}',
                              ),
                              buildRow(
                                context,
                                title: 'Ngày tạo',
                                content:
                                    result.createdAt.fullDateTime,
                              ),
                              buildStatus(
                                context,
                                status: result.status,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        foregroundColor:
                            context.colors.onPrimaryContainer,
                      ),
                      child: const Text('Theo dõi đơn hàng của bạn'),
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: .stretch,
                spacing: 8,
                children: [
                  SizedBox(
                    height: context.height * 0.5,
                    child: Column(
                      mainAxisAlignment: .center,
                      spacing: 8,
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Icon(Iconsax.bill_copy, size: 100),
                        ),
                        Text(
                          'Đặt hàng thành công',
                          style: context.textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: context.width * .8,
                          child: Text(
                            'Cảm ơn bạn đã đặt hàng, '
                            'vui lòng chờ nhận theo số thứ tự được hiển thị',
                            textAlign: .center,
                            style: context.textTheme.titleMedium!
                                .copyWith(
                                  color: context.colors.outline,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: .stretch,
                    spacing: 8,
                    children: [
                      Text(
                        'Chi tiết đơn hàng',
                        style: context.textTheme.bodyLarge,
                      ),
                      Container(
                        padding: const .all(16),
                        decoration: BoxDecoration(
                          borderRadius: .circular(16),
                          border: .all(color: context.colors.outline),
                        ),
                        child: Column(
                          spacing: 16,
                          children: [
                            buildRow(
                              context,
                              title: 'Số thứ tự',
                              content: '1',
                            ),
                            buildRow(
                              context,
                              title: 'Mã đơn hàng',
                              content: '1234-567765-4321-891021',
                            ),
                            buildRow(
                              context,
                              title: 'Ngày tạo',
                              content: DateTime.now().fullDateTime,
                            ),
                            buildStatus(
                              context,
                              status: OrderStatus.confirmed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Xem đơn hàng của bạn'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const .all(16),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: () => context.go(AppRouter.home),
                child: const Text('Trở về trang chủ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: .bold,
            color: context.colors.primary.withValues(alpha: .5),
          ),
        ),
        Text(content, style: context.textTheme.labelLarge),
      ],
    );
  }

  Widget _buildStatusData(
    BuildContext context, {
    required Color color,
    required String text,
    IconData? icon,
  }) {
    return Row(
      spacing: 4,
      children: [
        Text(
          text,
          style: context.textTheme.labelLarge!.copyWith(color: color),
        ),
        if (icon != null) Icon(icon, color: color),
      ],
    );
  }

  Row buildStatus(
    BuildContext context, {
    required OrderStatus status,
  }) {
    late Widget statusWidget;
    switch (status) {
      case .confirmed:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.primary,
          text: status.label,
          icon: Iconsax.tick_circle_copy,
        );
      case .preparing:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.primary,
          text: status.label,
        );
      case .completed:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.primary,
          text: status.label,
        );
      case .cancelled:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.error,
          text: status.label,
          icon: Iconsax.close_circle_copy,
        );
    }

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          'Trạng thái',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: .bold,
            color: context.colors.primary.withValues(alpha: .5),
          ),
        ),
        statusWidget,
      ],
    );
  }
}
