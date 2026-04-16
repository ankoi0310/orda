import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/analytics/domain/entities/weekday_stats.dart';
import 'package:orda/features/analytics/domain/usecases/get_weekly_stats_use_case.dart';

part 'weekly_analytic_state.dart';

class WeeklyAnalyticCubit extends Cubit<WeeklyAnalyticState> {
  WeeklyAnalyticCubit({required GetWeeklyStatsUseCase getWeeklyStats})
    : _getWeeklyStats = getWeeklyStats,
      super(AnalyticsInitial());

  final GetWeeklyStatsUseCase _getWeeklyStats;

  Future<void> getWeeklyStats() async {
    final result = await _getWeeklyStats();

    result.fold(
      (failure) => emit(AnalyticsError(failure.message)),
      (stats) => emit(GetWeeklyStatsSuccess(stats)),
    );
  }
}
