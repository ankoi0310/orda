import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/router/app_router.dart';

class NavItem extends Equatable {
  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;

  @override
  List<Object?> get props => [label, icon, activeIcon, route];
}

final List<NavItem> navItems = [
  const NavItem(
    label: 'Trang chủ',
    icon: Iconsax.home_copy,
    activeIcon: Iconsax.home,
    route: AppRouter.home,
  ),
  const NavItem(
    label: 'Đơn hàng',
    icon: Iconsax.receipt_2_1_copy,
    activeIcon: Iconsax.receipt_2_1,
    route: AppRouter.order,
  ),
  const NavItem(
    label: 'Hồ sơ',
    icon: Iconsax.user_copy,
    activeIcon: Iconsax.user,
    route: AppRouter.profile,
  ),
];
