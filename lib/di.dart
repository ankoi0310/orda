import 'package:get_it/get_it.dart';
import 'package:orda/core/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:orda/core/presentation/bloc/session/session_cubit.dart';
import 'package:orda/core/service/firebase_cloud_message_service.dart';
import 'package:orda/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:orda/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:orda/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:orda/features/analytics/domain/usecases/get_monthly_stats_use_case.dart';
import 'package:orda/features/analytics/domain/usecases/get_weekly_stats_use_case.dart';
import 'package:orda/features/analytics/presentation/bloc/monthly_analytic/monthly_analytic_cubit.dart';
import 'package:orda/features/analytics/presentation/bloc/weekly_analytic/weekly_analytic_cubit.dart';
import 'package:orda/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:orda/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:orda/features/auth/domain/repositories/auth_repository.dart';
import 'package:orda/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:orda/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:orda/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:orda/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:orda/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:orda/features/checkout/domain/usecases/checkout_with_cash_use_case.dart';
import 'package:orda/features/checkout/domain/usecases/initiate_payment_use_case.dart';
import 'package:orda/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:orda/features/order/data/datasources/order_remote_data_source.dart';
import 'package:orda/features/order/data/repositories/order_repository_impl.dart';
import 'package:orda/features/order/domain/repositories/order_repository.dart';
import 'package:orda/features/order/domain/usecases/get_order_history_use_case.dart';
import 'package:orda/features/order/domain/usecases/get_order_use_case.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';
import 'package:orda/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:orda/features/shop/domain/repositories/shop_repository.dart';
import 'package:orda/features/shop/domain/usecases/get_shop_use_case.dart';
import 'package:orda/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:orda/features/user/data/datasource/user_remote_data_source.dart';
import 'package:orda/features/user/data/repositories/user_repository_impl.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';
import 'package:orda/features/user/domain/usecases/change_password_use_case.dart';
import 'package:orda/features/user/domain/usecases/get_user_profile_use_case.dart';
import 'package:orda/features/user/domain/usecases/sign_out_use_case.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  sl
    ..registerLazySingleton(() => Supabase.instance.client)
    ..registerLazySingleton(() => NotificationService(supabase: sl()))
    ..registerLazySingleton(NavigationCubit.new)
    ..registerLazySingleton(
      () => SessionCubit(supabase: sl(), notificationService: sl()),
    )
    ..registerFactory(CartCubit.new);

  _initAuth(sl);
  _initShop(sl);
  _initCheckout(sl);
  _initOrder(sl);
  _initUser(sl);
  _initAnalytics(sl);
}

void _initAuth(GetIt sl) {
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => SignInWithPasswordUseCase(repository: sl()),
    )
    ..registerFactory(() => AuthBloc(signInWithPassword: sl()));
}

void _initShop(GetIt sl) {
  sl
    ..registerLazySingleton<ShopRemoteDataSource>(
      () => ShopRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<ShopRepository>(
      () => ShopRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(() => GetShopUseCase(repository: sl()))
    ..registerFactory(() => ShopBloc(getShop: sl()));
}

void _initCheckout(GetIt sl) {
  sl
    ..registerLazySingleton<CheckoutRemoteDataSource>(
      () => CheckoutRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => CheckoutWithCashUseCase(repository: sl()),
    )
    ..registerLazySingleton(InitiatePaymentUseCase.new)
    ..registerFactoryParam<CheckoutCubit, String, void>(
      (shopId, _) => CheckoutCubit(
        shopId: shopId,
        initiatePayment: sl(),
        checkoutWithCash: sl(),
      ),
    );
}

void _initOrder(GetIt sl) {
  sl
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetOrderHistoryUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetOrderDetailUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => OrderBloc(getOrderHistory: sl(), getOrderDetail: sl()),
    );
}

void _initUser(GetIt sl) {
  sl
    ..registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetUserProfileUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => ChangePasswordUseCase(repository: sl()),
    )
    ..registerLazySingleton(() => SignOutUseCase(repository: sl()))
    ..registerFactory(
      () => UserBloc(
        getUserProfile: sl(),
        changePassword: sl(),
        signOut: sl(),
      ),
    );
}

void _initAnalytics(GetIt sl) {
  sl
    ..registerLazySingleton<AnalyticsRemoteDataSource>(
      () => AnalyticsRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetMonthlyStatsUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetWeeklyStatsUseCase(repository: sl()),
    )
    ..registerFactory(
      () => MonthlyAnalyticCubit(getMonthlyStats: sl()),
    )
    ..registerFactory(
      () => WeeklyAnalyticCubit(getWeeklyStats: sl()),
    );
}
