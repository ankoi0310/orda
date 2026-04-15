import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.child,
    this.padding,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsetsGeometry.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: context.colors.outline,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
