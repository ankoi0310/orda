import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/analytics/presentation/bloc/monthly_analytic/monthly_analytic_cubit.dart';

class MonthlyOverview extends StatelessWidget {
  const MonthlyOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyAnalyticCubit, MonthlyAnalyticState>(
      builder: (context, state) {
        var totalOrders = 0;
        var monthSpending = 0;

        if (state is GetMonthlyStatsSuccess) {
          totalOrders = state.stats.totalOrders;
          monthSpending = state.stats.monthSpending;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Thật tuyệt vời! Bạn đã quét mã để đặt ',
                ),
                TextSpan(
                  text: '$totalOrders',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colors.onPrimary,
                  ),
                ),
                const TextSpan(text: ' đơn hàng và chi tiêu '),
                TextSpan(
                  text: monthSpending.toVND(),
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colors.onPrimary,
                  ),
                ),
                const TextSpan(text: ' trong tháng này.'),
              ],
            ),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.outlineVariant,
              fontWeight: .w600,
            ),
          ),
        );
      },
    );
  }
}
