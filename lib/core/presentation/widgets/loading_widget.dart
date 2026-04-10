import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: context.colors.inverseSurface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(),
        ),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              backgroundColor: context.colors.primaryContainer,
            ),
            if (text != null && text!.trim().isNotEmpty)
              Text(
                text!,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.onInverseSurface,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
