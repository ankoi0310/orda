import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/domain/entities/monthly_stats.dart';
import 'package:orda/features/analytics/domain/entities/weekday_stats.dart';

abstract class AnalyticsRepository {
  ResultFuture<MonthlyStats> getMonthlyStats();
  ResultFuture<List<WeekdayStats>> getWeeklyStats();
}
