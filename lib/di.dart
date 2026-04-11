import 'package:get_it/get_it.dart';
import 'package:orda/core/presentation/bloc/session/session_cubit.dart';
import 'package:orda/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:orda/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:orda/features/auth/domain/repositories/auth_repository.dart';
import 'package:orda/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:orda/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda/features/order/data/datasources/order_remote_data_source.dart';
import 'package:orda/features/order/data/repositories/order_repository_impl.dart';
import 'package:orda/features/order/domain/repositories/order_repository.dart';
import 'package:orda/features/order/domain/usecases/get_order_list_use_case.dart';
import 'package:orda/features/order/domain/usecases/get_order_use_case.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';
import 'package:orda/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:orda/features/shop/domain/repositories/shop_repository.dart';
import 'package:orda/features/shop/domain/usecases/load_shop_use_case.dart';
import 'package:orda/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:orda/features/user/data/datasource/user_remote_data_source.dart';
import 'package:orda/features/user/data/repositories/user_repository_impl.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';
import 'package:orda/features/user/domain/usecases/get_user_profile_use_case.dart';
import 'package:orda/features/user/domain/usecases/sign_out_use_case.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  sl
    ..registerLazySingleton(() => Supabase.instance.client)
    ..registerLazySingleton(() => AuthSessionCubit(sl()));

  _initAuth(sl);
  _initShop(sl);
  _initOrder(sl);
  _initUser(sl);
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
    ..registerLazySingleton(() => LoadShopUseCase(repository: sl()))
    ..registerFactory(() => ShopBloc(loadShop: sl()));
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
      () => GetOrderListUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetOrderDetailUseCase(repository: sl()),
    )
    ..registerFactory(
      () => OrderBloc(getOrderList: sl(), getOrderDetail: sl()),
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
    ..registerLazySingleton(() => SignOutUseCase(repository: sl()))
    ..registerFactory(
      () => UserBloc(getUserProfile: sl(), signOut: sl()),
    );
}
