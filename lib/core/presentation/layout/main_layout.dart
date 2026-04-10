import 'package:flutter/material.dart';
import 'package:orda/core/presentation/widgets/main_bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
