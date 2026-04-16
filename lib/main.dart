import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orda/app.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/constant/app_constants.dart';
import 'package:orda/core/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:orda/core/presentation/bloc/session/session_cubit.dart';
import 'package:orda/di.dart';
import 'package:orda/features/order/presentation/bloc/order_bloc.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:orda/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabasePublishableKey,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initInjection();

  AppRouter.setupRouterListener();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NavigationCubit>()),
        BlocProvider(create: (_) => sl<SessionCubit>()),
        BlocProvider(create: (_) => sl<OrderBloc>()),
        BlocProvider(create: (_) => sl<UserBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
