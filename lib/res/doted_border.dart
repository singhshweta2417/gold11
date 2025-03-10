import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white // Border color
      ..strokeWidth = 1.5 // Border thickness
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4.0;
    const double dashSpace = 2.0;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    double currentAngle = 0.0;
    final double circumference = 2 * 3.141592653589793 * radius; // Circumference of the circle
    final double dashAngle = (dashWidth / circumference) * 360; // Convert dash width to angle
    final double gapAngle = (dashSpace / circumference) * 360; // Convert dash gap to angle

    while (currentAngle < 360) {
      final double startAngle = currentAngle;
      final double sweepAngle = dashAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * (3.141592653589793 / 180), // Convert to radians
        sweepAngle * (3.141592653589793 / 180), // Convert to radians
        false,
        paint,
      );
      currentAngle += dashAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
