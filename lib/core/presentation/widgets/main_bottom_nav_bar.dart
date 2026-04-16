import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda/core/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:orda/core/presentation/models/nav_item.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return BottomNavigationBar(
          elevation: 0,
          onTap: (index) {
            if (index == currentIndex) return;

            context.read<NavigationCubit>().setIndex(index);
            context.go(navItems[index].route);
          },
          currentIndex: currentIndex,
          items: navItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.label,
            );
          }).toList(),
        );
      },
    );
  }
}
