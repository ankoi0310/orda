import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/utils/app_util.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';
import 'package:orda/features/user/presentation/widgets/section_container.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserError) {
          showSnackBar(context, content: state.message);
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          final userProfile = state.userProfile;
          return _buildUserProfileSection(
            context,
            fullName: userProfile.fullName,
            email: userProfile.email,
          );
        }

        // skeleton
        return Skeletonizer(child: _buildUserProfileSection(context));
      },
    );
  }

  Widget _buildUserProfileSection(
    BuildContext context, {
    String fullName = 'fake full name',
    String email = 'email@example.com',
  }) {
    return SectionContainer(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: const Skeleton.keep(
          child: CircleAvatar(
            radius: 24,
            child: Icon(Iconsax.user_copy),
          ),
        ),
        title: Text(fullName, style: context.textTheme.labelLarge),
        subtitle: Text(email, style: context.textTheme.labelMedium),
      ),
    );
  }
}
