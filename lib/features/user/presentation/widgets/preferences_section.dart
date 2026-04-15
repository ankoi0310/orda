import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/utils/app_util.dart';
import 'package:orda/features/user/presentation/widgets/section_container.dart';
import 'package:orda/features/user/presentation/widgets/user_action_list_tile.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Cài đặt ứng dụng',
              style: context.textTheme.bodyLarge,
            ),
          ),
          UserActionListTile(
            onTap: () {
              showSnackBar(context, content: 'Toggle notification');
            },
            leadingIcon: Iconsax.notification_copy,
            title: 'Thông báo',
            subTitle: 'Cài đặt nhận thông báo từ ứng dụng',
          ),
          const UserActionListTile(
            leadingIcon: Iconsax.info_circle_copy,
            title: 'FAQs',
            subTitle: 'Giải đáp một số thắc mắc về ứng dụng',
          ),
          const UserSignOutListTile(),
        ],
      ),
    );
  }
}
