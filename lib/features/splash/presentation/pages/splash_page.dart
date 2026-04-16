import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/presentation/bloc/session/session_cubit.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionCubit>().state;

    if (sessionState.isAuthenticated) {
      context.read<OrderBloc>().add(LoadOrderHistory());
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<OrderBloc, OrderState>(
          listener: (context, state) async {
            if (state is LoadingOrderHistory) {
              context.go(AppRouter.home);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Assets.images.blankItem.image(
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
