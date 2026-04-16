import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/analytics/presentation/bloc/weekly_analytic/weekly_analytic_cubit.dart';
import 'package:orda/features/home/presentation/widgets/weekly_bar_chart.dart';

class WeeklyAnalyticsSection extends StatelessWidget {
  const WeeklyAnalyticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        Text(
          'Thống kê hàng tuần',
          style: context.textTheme.bodyLarge,
        ),
        Column(
          crossAxisAlignment: .stretch,
          spacing: 4,
          children: [
            BlocBuilder<WeeklyAnalyticCubit, WeeklyAnalyticState>(
              builder: (context, state) {
                var data = <int>[0, 0, 0, 0, 0, 0, 0];
                var maxY = 0;

                if (state is GetWeeklyStatsSuccess) {
                  data = state.weeklyStats.map((weekdayStat) {
                    maxY = max(maxY, weekdayStat.totalOrders);
                    return weekdayStat.totalOrders;
                  }).toList();
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: .circular(12),
                    border: .all(),
                  ),
                  child: WeeklyBarChart(
                    data: data,
                    maxY: maxY.toDouble() * 1.5,
                  ),
                );
              },
            ),
            Text(
              'Thống kê đơn hàng',
              textAlign: .center,
              style: context.textTheme.bodyMedium!.copyWith(
                fontStyle: .italic,
              ),
            ),
          ],
        ),
        Column(
          spacing: 4,
          children: [
            BlocBuilder<WeeklyAnalyticCubit, WeeklyAnalyticState>(
              builder: (context, state) {
                var data = <double>[0, 0, 0, 0, 0, 0, 0];
                double maxY = 0;

                if (state is GetWeeklyStatsSuccess) {
                  data = state.weeklyStats.map((weekdayStat) {
                    maxY = max(
                      maxY,
                      weekdayStat.totalSpending / 1000,
                    );
                    return weekdayStat.totalSpending / 1000;
                  }).toList();
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: .circular(12),
                    border: .all(),
                  ),
                  child: WeeklyBarChart(data: data, maxY: maxY * 1.5),
                );
              },
            ),
            Text(
              'Thống kê chi tiêu (VNĐ)',
              style: context.textTheme.bodyMedium!.copyWith(
                fontStyle: .italic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
