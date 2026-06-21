import 'dart:math';
import 'package:flutter/material.dart';

class DashedCircleWidget extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Widget? child;

  const DashedCircleWidget({
    super.key,
    required this.size,
    this.color = Colors.blue,
    this.strokeWidth = 3,
    this.dashWidth = 8,
    this.dashSpace = 6,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _DashedCirclePainter(
              color: color,
              strokeWidth: strokeWidth,
              dashWidth: dashWidth,
              dashSpace: dashSpace,
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = (size.width - strokeWidth) / 2;
    final circumference = 2 * pi * radius;
    final dashCount = circumference ~/ (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      final startAngle =
          (i * (dashWidth + dashSpace)) / radius;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radius,
        ),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
