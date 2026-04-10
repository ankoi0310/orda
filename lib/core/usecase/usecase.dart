import 'package:orda/core/utils/typedefs.dart';

abstract class UseCase<ReturnType, Params> {
  ResultFuture<ReturnType> call(Params params);
}

abstract class UseCaseWithoutParams<ReturnType> {
  ResultFuture<ReturnType> call();
}
