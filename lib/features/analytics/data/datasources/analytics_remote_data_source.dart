import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/data/models/monthly_stats_model.dart';
import 'package:orda/features/analytics/data/models/weekly_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AnalyticsRemoteDataSource {
  Future<MonthlyStatsModel> getMonthlyStats();

  Future<List<WeeklyStatsModel>> getWeeklyStats();
}

class AnalyticsRemoteDataSourceImpl
    implements AnalyticsRemoteDataSource {
  const AnalyticsRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<MonthlyStatsModel> getMonthlyStats() async {
    return client
        .rpc<MonthlyStatsModel>('get_user_month_stats')
        .single()
        .withConverter(MonthlyStatsModel.fromJson);
  }

  @override
  Future<List<WeeklyStatsModel>> getWeeklyStats() async {
    return client
        .rpc<List<JsonData>>('get_weekly_stats')
        .withConverter(
          (jsonList) => List<JsonData>.from(
            jsonList as List,
          ).map(WeeklyStatsModel.fromJson).toList(),
        );
  }
}
