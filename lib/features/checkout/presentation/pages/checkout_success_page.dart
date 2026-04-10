import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/enum/order_status.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/date_time_extension.dart';
import 'package:orda/core/extensions/order_status_extension.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              SizedBox(
                height: context.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        'Cảm ơn bạn đã đặt hàng, vui lòng chờ nhận theo số thứ tự được hiển thị',
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium!
                            .copyWith(color: context.colors.outline),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(
                    'Chi tiết đơn hàng',
                    style: context.textTheme.bodyLarge,
                  ),
                  Container(
                    padding: const EdgeInsetsGeometry.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      border: Border.all(
                        color: context.colors.outline,
                      ),
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
              FilledButton.tonal(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  foregroundColor: context.colors.onPrimaryContainer,
                ),
                child: const Text('Theo dõi đơn hàng của bạn'),
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
                onPressed: () => context.push(AppRouter.home),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.outline,
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
      case OrderStatus.confirmed:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.primary,
          text: status.label,
          icon: Iconsax.tick_circle_copy,
        );
      case OrderStatus.ready:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.primary,
          text: status.label,
        );
      case OrderStatus.completed:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.primary,
          text: status.label,
        );
      case OrderStatus.cancelled:
        statusWidget = _buildStatusData(
          context,
          color: context.colors.error,
          text: status.label,
          icon: Iconsax.close_circle_copy,
        );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Trạng thái',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.outline,
          ),
        ),
        statusWidget,
      ],
    );
  }
}
