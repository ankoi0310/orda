import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/user/presentation/widgets/change_password_modal.dart';
import 'package:orda/features/user/presentation/widgets/section_container.dart';
import 'package:orda/features/user/presentation/widgets/user_action_list_tile.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: Text(
              'Thông tin tài khoản',
              style: context.textTheme.bodyLarge!.copyWith(),
            ),
          ),
          UserActionListTile(
            onTap: () {},
            leadingIcon: Iconsax.user_edit_copy,
            title: 'Cập nhật hồ sơ',
            subTitle: 'Thay đổi họ tên, ảnh đại diện',
          ),
          UserActionListTile(
            onTap: () async {
              await showModalBottomSheet<dynamic>(
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: .directional(
                    topStart: .circular(16),
                    topEnd: .circular(16),
                  ),
                ),
                builder: (context) => const ChangePasswordModal(),
              );
            },
            leadingIcon: Iconsax.lock_1_copy,
            title: 'Đổi mật khẩu',
            subTitle: 'Cập nhật mật khẩu mới cho tài khoản',
          ),
        ],
      ),
    );
  }
}
