import 'package:flutter/material.dart';

class QrScannerOverlay extends StatelessWidget {
  const QrScannerOverlay({super.key, this.size = 250});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: const QrBorderPainter(),
    );
  }
}

class QrBorderPainter extends CustomPainter {
  const QrBorderPainter({
    this.radius = 16,
    this.strokeWidth = 4,
    this.cornerLength = 30,
  });

  final double radius;
  final double strokeWidth;
  final double cornerLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      // Top-left
      ..moveTo(0, cornerLength)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..lineTo(cornerLength, 0)
      // Top-right
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, cornerLength)
      // Bottom-left
      ..moveTo(0, size.height - cornerLength)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(
        Offset(radius, size.height),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(cornerLength, size.height)
      // Bottom-right
      ..moveTo(size.width - cornerLength, size.height)
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(
        Offset(size.width, size.height - radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
