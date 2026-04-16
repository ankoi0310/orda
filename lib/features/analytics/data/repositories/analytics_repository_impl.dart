import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:orda/features/analytics/domain/entities/monthly_stats.dart';
import 'package:orda/features/analytics/domain/entities/weekday_stats.dart';
import 'package:orda/features/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  const AnalyticsRepositoryImpl({required this.remoteDataSource});

  final AnalyticsRemoteDataSource remoteDataSource;

  @override
  ResultFuture<MonthlyStats> getMonthlyStats() async {
    try {
      final stats = await remoteDataSource.getMonthlyStats();
      return Right(stats);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<List<WeekdayStats>> getWeeklyStats() async {
    try {
      final stats = await remoteDataSource.getWeeklyStats();
      print(stats);
      return Right(stats);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
