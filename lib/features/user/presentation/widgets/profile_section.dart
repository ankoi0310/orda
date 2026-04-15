import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:orda/features/user/presentation/widgets/section_container.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoadingUserProfile) {
          return const SectionContainer(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                child: CircularProgressIndicator(),
              ),
              title: Text('Đang tải...'),
            ),
          );
        }

        if (state is UserError) {}

        if (state is UserSuccess) {
          final userProfile = state.userProfile;
          return SectionContainer(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 24,
                child: Icon(Iconsax.user_copy),
              ),
              title: Text(
                userProfile.fullName,
                style: context.textTheme.labelLarge,
              ),
              subtitle: Text(
                userProfile.email,
                style: context.textTheme.labelMedium,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
