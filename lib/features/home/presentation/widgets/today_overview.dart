import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class TodayOverview extends StatelessWidget {
  const TodayOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            'Tổng quan hôm nay',
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colors.onPrimary,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  children: [
                    Text(
                      'Đơn hàng đã đặt',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                    Text(
                      '18',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  children: [
                    Text(
                      'Số tiền đã tiêu (VND)',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),
                    Text(
                      '10.000.000',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
