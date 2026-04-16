import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/domain/entities/monthly_stats.dart';

class MonthlyStatsModel extends MonthlyStats {
  const MonthlyStatsModel({
    required super.totalOrders,
    required super.monthSpending,
  });

  factory MonthlyStatsModel.fromJson(JsonData json) {
    return MonthlyStatsModel(
      totalOrders: json['total_orders'] as int,
      monthSpending: json['month_spending'] as int,
    );
  }
}
