import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.controller,
    required this.focusNode,
    this.enabled = true,
    this.hintText,
    this.onFieldSubmitted,
    this.validator,
    super.key,
  });

  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(hintText: hintText),
      onFieldSubmitted: onFieldSubmitted,
      selectAllOnFocus: true,
      enableInteractiveSelection: true,
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
      validator: validator,
    );
  }
}

class AppPasswordFormField extends StatefulWidget {
  const AppPasswordFormField({
    required this.controller,
    required this.focusNode,
    this.enabled = true,
    this.onFieldSubmitted,
    super.key,
  });

  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onFieldSubmitted;

  @override
  State<AppPasswordFormField> createState() =>
      _AppPasswordFormFieldState();
}

class _AppPasswordFormFieldState extends State<AppPasswordFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: 'Nhập mật khẩu của bạn',
        suffixIcon: GestureDetector(
          onTap: () => setState(() {
            isObscure = !isObscure;
          }),
          child: Icon(
            isObscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy,
          ),
        ),
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
      selectAllOnFocus: true,
      enableInteractiveSelection: true,
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Mật khẩu không được để trống';
        }

        return null;
      },
    );
  }
}
