import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orda/core/presentation/models/nav_item.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
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
  }
}
