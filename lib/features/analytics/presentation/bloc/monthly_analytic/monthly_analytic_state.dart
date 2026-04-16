part of 'monthly_analytic_cubit.dart';

sealed class MonthlyAnalyticState extends Equatable {
  const MonthlyAnalyticState();

  @override
  List<Object> get props => [];
}

final class AnalyticsInitial extends MonthlyAnalyticState {}

final class GetMonthlyStatsSuccess extends MonthlyAnalyticState {
  const GetMonthlyStatsSuccess(this.stats);

  final MonthlyStats stats;

  @override
  List<Object> get props => [stats];
}

final class AnalyticsError extends MonthlyAnalyticState {
  const AnalyticsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
