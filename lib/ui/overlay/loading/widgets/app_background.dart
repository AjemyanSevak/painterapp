import 'package:flutter/material.dart';
import 'package:painter_app/base/base.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.backgroundimage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints.expand(),
          color: Color(0xff131313).withValues(alpha: 0.75),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.pattern),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
