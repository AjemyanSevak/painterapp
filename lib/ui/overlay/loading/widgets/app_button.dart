import 'package:flutter/material.dart';
import 'package:painter_app/base/base.dart';
import 'package:painter_app/base/text_styles.dart';
import 'package:painter_app/ui/overlay/loading/widgets/loading.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final double radius;
  final bool showLoading;
  final Color loadingColor;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primaryGradient,
    this.radius = 8,
    this.showLoading = false,
    this.loadingColor = AppColors.whiter,
  });

  bool get _enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final height = 48.0;
    final textStyle = AppTextStyles.bodyLargeMedium.copyWith(
      fontSize: 17,
      color: _textColor,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 88),
      child: SizedBox(
        width: 335,
        height: height,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            decoration: BoxDecoration(
              gradient: _gradient,
              color: _fillColor,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: _enabled ? onPressed : null,
              child: Padding(
                // Figma padding: 12 / 16 / 12 / 16
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: showLoading
                          ? AppLoading(color: loadingColor, size: 22)
                          : Text(
                              label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- Style
  LinearGradient? get _gradient {
    switch (variant) {
      case AppButtonVariant.primaryGradient:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.secondary, AppColors.primary],
        );
      default:
        return null;
    }
  }

  // Disabled gradient (dimmed) for primaryGradient only

  // Solid fill colors for non-gradient variants
  Color? get _fillColor {
    switch (variant) {
      case AppButtonVariant.primaryGradient:
        return null; // gradient used
      case AppButtonVariant.primaryLight:
        return Colors.white;
      case AppButtonVariant.neutral:
        return const Color(0xFF6B6B6B); // medium gray
      case AppButtonVariant.destructive:
        return const Color(0xFFE74D4D); // red
    }
  }

  // Text & icon colors based on variant
  Color get _textColor {
    switch (variant) {
      case AppButtonVariant.primaryGradient:
        return AppColors.whiter;
      case AppButtonVariant.primaryLight:
        return const Color(0xff131313); // almost black
      case AppButtonVariant.neutral:
        return AppColors.darkgrey;
      case AppButtonVariant.destructive:
        return AppColors.white;
    }
  }
}
