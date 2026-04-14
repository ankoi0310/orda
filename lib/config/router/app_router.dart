import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda/config/router/session_listenable.dart';
import 'package:orda/core/presentation/bloc/session/session_cubit.dart';
import 'package:orda/core/presentation/layout/main_layout.dart';
import 'package:orda/di.dart';
import 'package:orda/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda/features/auth/presentation/pages/login_page.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:orda/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:orda/features/checkout/presentation/pages/checkout_page.dart';
import 'package:orda/features/checkout/presentation/pages/checkout_success_page.dart';
import 'package:orda/features/home/presentation/pages/home_page.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';
import 'package:orda/features/order/presentation/pages/order_history_page.dart';
import 'package:orda/features/scan/presentation/pages/scan_page.dart';
import 'package:orda/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:orda/features/shop/presentation/pages/shop_detail_page.dart';
import 'package:orda/features/user/presentation/pages/user_profile_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String order = '/order';
  static const String profile = '/profile';
  static const String scan = '/scan';
  static const String shopDetail = '/shop';
  static const String checkout = '/checkout';

  static final config = GoRouter(
    initialLocation: home,
    refreshListenable: SessionListenable(sl<SessionCubit>().stream),
    routes: [
      ShellRoute(
        builder: (context, state, child) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<OrderBloc>()),
          ],
          child: MainLayout(child: child),
        ),
        routes: [
          GoRoute(
            path: home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: order,
            builder: (context, state) => const OrderHistoryPage(),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const UserProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const LoginPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (context) => sl<ShopBloc>(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: scan,
            builder: (context, state) => const ScanPage(),
          ),
          ShellRoute(
            builder: (context, state, child) {
              final shopId = state.extra is String
                  ? state.extra! as String
                  : null;
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<CartCubit>()),
                  BlocProvider(
                    create: (_) => sl<CheckoutCubit>(param1: shopId),
                  ),
                ],
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: shopDetail,
                builder: (context, state) {
                  return const ShopDetailPage();
                },
              ),
              GoRoute(
                path: checkout,
                builder: (context, state) => const CheckoutPage(),
                routes: [
                  GoRoute(
                    path: '/success',
                    builder: (context, state) =>
                        const CheckoutSuccessPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = sl<SessionCubit>().state;

      final isLogin = state.matchedLocation == login;

      /// Nếu chưa đăng nhập
      if (authState is Unauthenticated) {
        return isLogin ? null : login;
      }

      /// Nếu đã đăng nhập
      if (authState is Authenticated) {
        if (isLogin) {
          return home;
        }
        return null;
      }

      return null;
    },
  );
}
