import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/domain/entities/weekday_stats.dart';
import 'package:orda/features/analytics/domain/repositories/analytics_repository.dart';

class GetWeeklyStatsUseCase
    implements UseCaseWithoutParams<List<WeekdayStats>> {
  const GetWeeklyStatsUseCase({required this.repository});

  final AnalyticsRepository repository;

  @override
  ResultFuture<List<WeekdayStats>> call() async {
    return repository.getWeeklyStats();
  }
}
