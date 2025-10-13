import 'package:flutter/material.dart';

class InnerShadowPainter extends CustomPainter {
  final double radius;
  final double blur; // Figma: 40
  final Offset offset; // Figma: (0, 1)
  final Color color; // Figma: #E3E3E3 @ 20%
  final double thickness; // ring thickness before blur (2–8 looks good)

  InnerShadowPainter({
    required this.radius,
    required this.blur,
    required this.offset,
    required this.color,
    this.thickness = 6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Outer rounded rect (card bounds)
    final outer = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Slightly smaller rounded rect to make a "ring" we’ll blur
    final innerRect = rect.deflate(thickness);
    final inner = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular((radius - thickness).clamp(0, radius)),
    );

    // Even-odd path => hollow ring
    final ring = Path()
      ..addRRect(outer)
      ..addRRect(inner)
      ..fillType = PathFillType.evenOdd;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    canvas.drawPath(ring, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant InnerShadowPainter old) =>
      old.radius != radius ||
      old.blur != blur ||
      old.offset != offset ||
      old.color != color ||
      old.thickness != thickness;
}
