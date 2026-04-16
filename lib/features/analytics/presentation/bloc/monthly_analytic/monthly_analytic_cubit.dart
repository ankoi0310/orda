import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/analytics/domain/entities/monthly_stats.dart';
import 'package:orda/features/analytics/domain/usecases/get_monthly_stats_use_case.dart';

part 'monthly_analytic_state.dart';

class MonthlyAnalyticCubit extends Cubit<MonthlyAnalyticState> {
  MonthlyAnalyticCubit({
    required GetMonthlyStatsUseCase getMonthlyStats,
  }) : _getMonthlyStats = getMonthlyStats,
       super(AnalyticsInitial());

  final GetMonthlyStatsUseCase _getMonthlyStats;

  Future<void> getMonthlyStats() async {
    final result = await _getMonthlyStats();

    result.fold(
      (failure) => emit(AnalyticsError(failure.message)),
      (stats) => emit(GetMonthlyStatsSuccess(stats)),
    );
  }
}
