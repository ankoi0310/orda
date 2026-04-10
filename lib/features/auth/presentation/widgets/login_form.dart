import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/string_extension.dart';
import 'package:orda/core/presentation/widgets/text_form_field.dart';
import 'package:orda/features/auth/presentation/bloc/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        SignInWithPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text('Email', style: context.textTheme.bodyLarge),
                  AppTextFormField(
                    enabled: state is! AuthLoading,
                    controller: emailController,
                    focusNode: emailFocusNode,
                    hintText: 'Nhập email của bạn',
                    onFieldSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email Không được để trống';
                      }

                      if (!value.isEmail) {
                        return 'Email không hợp lệ';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Mật khẩu',
                    style: context.textTheme.bodyLarge,
                  ),
                  AppPasswordFormField(
                    enabled: state is! AuthLoading,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (value) => _onSubmit(),
                  ),
                ],
              ),
              Text.rich(
                textAlign: TextAlign.end,
                TextSpan(
                  text: 'Quên mật khẩu?',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.error,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : _onSubmit,
                  child: const Text('Đăng nhập'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
