import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/domain/entities/monthly_stats.dart';
import 'package:orda/features/analytics/domain/repositories/analytics_repository.dart';

class GetMonthlyStatsUseCase
    implements UseCaseWithoutParams<MonthlyStats> {
  const GetMonthlyStatsUseCase({required this.repository});

  final AnalyticsRepository repository;

  @override
  ResultFuture<MonthlyStats> call() async {
    return repository.getMonthlyStats();
  }
}
