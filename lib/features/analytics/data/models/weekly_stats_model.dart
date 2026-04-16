import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/domain/entities/weekday_stats.dart';

class WeeklyStatsModel extends WeekdayStats {
  const WeeklyStatsModel({
    required super.weekday,
    required super.totalOrders,
    required super.totalSpending,
  });

  factory WeeklyStatsModel.fromJson(JsonData json) {
    return WeeklyStatsModel(
      weekday: json['weekday'] as int,
      totalOrders: json['total_orders'] as int,
      totalSpending: json['total_spending'] as int,
    );
  }
}
