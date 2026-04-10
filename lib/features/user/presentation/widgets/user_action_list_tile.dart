import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';

class UserActionListTile extends StatelessWidget {
  const UserActionListTile({
    required this.leadingIcon,
    required this.title,
    this.subTitle,
    this.onTap,
    super.key,
  });

  final IconData leadingIcon;
  final String title;
  final String? subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.primaryContainer.withValues(
              alpha: 0.5,
            ),
          ),
          child: Icon(
            leadingIcon,
            color: context.colors.primary,
            size: 20,
          ),
        ),
        title: Text(title, style: context.textTheme.labelLarge),
        subtitle: subTitle != null
            ? Text(
                subTitle!,
                style: context.textTheme.labelSmall!.copyWith(
                  color: context.colors.outline,
                ),
              )
            : null,
        trailing: Icon(
          Icons.chevron_right,
          color: context.colors.outline,
        ),
      ),
    );
  }
}

class UserSignOutListTile extends StatelessWidget {
  const UserSignOutListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.read<UserBloc>()..add(SignOut()),
      dense: true,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.errorContainer.withValues(alpha: 0.5),
        ),
        child: Icon(
          Iconsax.login_1_copy,
          color: context.colors.error,
          size: 20,
        ),
      ),
      title: Text(
        'Đăng xuất',
        style: context.textTheme.labelLarge!.copyWith(
          color: context.colors.error,
        ),
      ),
      subtitle: Text(
        'Securely sign out your account',
        style: context.textTheme.labelSmall!.copyWith(
          color: context.colors.outline,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: context.colors.outline,
      ),
    );
  }
}
