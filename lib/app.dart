import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/config/ui/theme/theme.dart';
import 'package:orda/core/utils/app_util.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((payload) {
      final notification = payload.notification;
      if (notification != null) {
        print(notification.title);
        print(notification.body);
      }
    });
  }

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
