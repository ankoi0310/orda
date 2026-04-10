import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/user/presentation/widgets/section_container.dart';
import 'package:orda/features/user/presentation/widgets/user_action_list_tile.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'General',
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.colors.outline,
              ),
            ),
          ),
          UserActionListTile(
            onTap: () {},
            leadingIcon: Iconsax.user_edit_copy,
            title: 'Cập nhật hồ sơ',
            subTitle: 'Thay đổi họ tên, ảnh đại diện',
          ),
          UserActionListTile(
            onTap: () {},
            leadingIcon: Iconsax.lock_1_copy,
            title: 'Đổi mật khẩu',
            subTitle: 'Cập nhật mật khẩu mới cho tài khoản',
          ),
        ],
      ),
    );
  }
}
