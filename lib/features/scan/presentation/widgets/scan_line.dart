import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class ScanLine extends StatefulWidget {
  const ScanLine({super.key});

  @override
  State<ScanLine> createState() => _ScanLineState();
}

class _ScanLineState extends State<ScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Positioned(
          top:
              context.height / 2 -
              250 / 2 +
              5 +
              controller.value * 240,
          child: Container(
            width: 240,
            height: 2,
            color: context.colors.primaryContainer,
          ),
        );
      },
    );
  }
}
