import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/analytics/presentation/bloc/monthly_analytic/monthly_analytic_cubit.dart';
import 'package:orda/features/analytics/presentation/bloc/weekly_analytic/weekly_analytic_cubit.dart';
import 'package:orda/features/home/presentation/widgets/monthly_overview.dart';
import 'package:orda/features/home/presentation/widgets/recent_orders_section.dart';
import 'package:orda/features/home/presentation/widgets/weekly_analytics_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MonthlyAnalyticCubit>().getMonthlyStats();
    context.read<WeeklyAnalyticCubit>().getWeeklyStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const .symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: context.colors.outlineVariant,
            borderRadius: const .only(
              topRight: .circular(16),
              bottomRight: .circular(16),
            ),
          ),
          child: Text(
            'Orda xin chào ✌️',
            style: context.textTheme.titleMedium!.copyWith(
              fontWeight: .bold,
            ),
          ),
        ),
        actionsPadding: const .only(right: 16),
        actions: [
          GestureDetector(
            onTap: () => context.push(AppRouter.scan),
            child: const Icon(Iconsax.scan_barcode_copy, size: 32),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: .all(16),
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 24,
            children: [
              MonthlyOverview(),
              WeeklyAnalyticsSection(),
              RecentOrdersSection(),
            ],
          ),
        ),
      ),
    );
  }
}
