import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/presentation/widgets/loading_widget.dart';
import 'package:orda/core/presentation/widgets/text_form_field.dart';
import 'package:orda/core/utils/app_util.dart';
import 'package:orda/features/user/domain/usecases/change_password_use_case.dart';
import 'package:orda/features/user/presentation/bloc/user_bloc.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() =>
      _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final currentPasswordFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUpdatePasswordSuccess) {
          showSnackBar(
            context,
            content: 'Cập nhật mật khẩu thành công',
          );
          context.read<UserBloc>().add(SignOut());
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const .all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: .stretch,
                      spacing: 16,
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          spacing: 8,
                          children: [
                            Text(
                              'Mật khẩu hiện tại',
                              style: context.textTheme.bodyLarge,
                            ),
                            AppPasswordFormField(
                              // enabled: state is! AuthLoading,
                              controller: currentPasswordController,
                              focusNode: currentPasswordFocusNode,
                              onFieldSubmitted: (value) =>
                                  newPasswordFocusNode.requestFocus(),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'Mật khẩu mới',
                              style: context.textTheme.bodyLarge,
                            ),
                            AppPasswordFormField(
                              // enabled: state is! AuthLoading,
                              controller: newPasswordController,
                              focusNode: newPasswordFocusNode,
                              onFieldSubmitted: (value) =>
                                  _onSubmit(),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _onSubmit,
                          child: const Text('Đổi mật khẩu'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is UpdatingUserPassword)
                const Positioned.fill(
                  child: LoadingWidget(text: 'Đang cập nhật...'),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      final params = ChangePasswordParams(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );
      context.read<UserBloc>().add(ChangePassword(params));
    }
  }
}
