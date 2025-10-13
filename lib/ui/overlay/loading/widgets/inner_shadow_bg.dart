import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:painter_app/ui/overlay/loading/widgets/inner_shadow_painter.dart';

class InnerShadowBg extends StatelessWidget {
  const InnerShadowBg({super.key});

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF87858F);

    return Stack(
      children: [
        // Subtle gradient under the blur (optional)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF16212C), Color(0xFF0F1A1C)],
            ),
          ),
        ),

        // Background blur (Figma 100 → visually similar with 25–30 and faster)
        SizedBox(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: const SizedBox.expand(),
          ),
        ),

        // // 0.5px border
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 0.5),
          ),
        ),

        // --- Inner shadow without any package ---
        Positioned.fill(
          child: CustomPaint(
            painter: InnerShadowPainter(
              radius: 20,
              blur: 40, // Figma
              offset: const Offset(0, 0), // Figma
              color: Color(0xffE3E3E3).withValues(alpha: 20), // 20% opacity
              thickness: 1, // tweak 4–8 if needed
            ),
          ),
        ),
      ],
    );
  }
}
