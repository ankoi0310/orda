part of 'weekly_analytic_cubit.dart';

sealed class WeeklyAnalyticState extends Equatable {
  const WeeklyAnalyticState();

  @override
  List<Object> get props => [];
}

final class AnalyticsInitial extends WeeklyAnalyticState {}

final class GetWeeklyStatsSuccess extends WeeklyAnalyticState {
  const GetWeeklyStatsSuccess(this.weeklyStats);

  final List<WeekdayStats> weeklyStats;

  @override
  List<Object> get props => [weeklyStats];
}

final class AnalyticsError extends WeeklyAnalyticState {
  const AnalyticsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
