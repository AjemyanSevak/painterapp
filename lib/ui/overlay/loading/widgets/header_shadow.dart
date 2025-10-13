import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:painter_app/base/colors/app_colors.dart';

class BlurredInnerShadowBox extends StatelessWidget {
  const BlurredInnerShadowBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                width: double.infinity,
                height: 102,
                color: const Color(
                  0xffC4C4C4,
                ).withValues(alpha: 0.1), // 1% opacity (0x03)
              ),
            ),

            // Inner shadow overlay
            Container(
              width: double.infinity,
              height: 102,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.overlay,
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
