import 'package:flutter/material.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/config/ui/theme/theme.dart';
import 'package:orda/core/utils/app_util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(
      context,
    ).platformDispatcher.platformBrightness;

    final textTheme = createTextTheme(context, 'Roboto', 'Mitr');
    final theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Orda',
      theme: brightness == Brightness.light
          ? theme.light()
          : theme.dark(),
      routerConfig: AppRouter.config,
    );
  }
}
