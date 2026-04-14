import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/date_time_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/order/domain/entities/order.dart';
import 'package:orda/features/order/presentation/widgets/order_item_field.dart';

class OrderDetailModal extends StatelessWidget {
  const OrderDetailModal({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      '#${order.orderNumber}',
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      '${order.totalPrice.toVND()} (${order.totalItems} món)',
                      style: context.textTheme.titleMedium!.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 8, color: context.colors.outline),
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            itemBuilder: (context, index) {
              final item = order.items[index];
              return OrderItemField(item: item);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
          ),
          Divider(thickness: 8, color: context.colors.outline),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const Text('Tạm tính'),
                    Text(order.totalPrice.toVND()),
                  ],
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const Text('Giảm giá'),
                    Text('-${0.toVND()}'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const Text(
                      'Tổng cộng',
                      style: TextStyle(fontWeight: .bold),
                    ),
                    Text(order.totalPrice.toVND()),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 8, color: context.colors.outline),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const Text('Ngày tạo'),
                    Text(
                      order.createdAt.fullTimeDate,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const Text('Phương thức thanh toán'),
                    Text(
                      'Tiền mặt',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const Text('Trạng thái'),
                    Text(
                      order.status.label,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
