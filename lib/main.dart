import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:orda/app.dart';
import 'package:orda/core/constant/app_constants.dart';
import 'package:orda/core/presentation/bloc/auth_session/auth_session_cubit.dart';
import 'package:orda/di.dart';
import 'package:orda/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabasePublishableKey,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getTemporaryDirectory()).path,
          ),
  );

  await initInjection();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthSessionCubit>()),
        BlocProvider(create: (_) => sl<CartBloc>()),
        BlocProvider(
          create: (_) => sl<UserBloc>()..add(GetUserProfile()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
