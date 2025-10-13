import 'package:flutter/material.dart';
import 'package:painter_app/base/keys/app_keys.dart';

class AppLoading extends StatelessWidget {
  static bool isActive = false;

  final Color? color;
  final double? size;
  final String? label;

  const AppLoading({super.key, this.color, this.size, this.label});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size ?? 50,
          height: size ?? 50,
          child: Center(
            child: CircularProgressIndicator(
              color: color ?? Theme.of(context).primaryColor,
              strokeWidth: 2,
            ),
          ),
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              label!,
              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                color: color ?? Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  static void show({final Color? color, final double? size}) {
    if (isActive) return;

    isActive = true;
    showDialog<void>(
      context: AppKeys.navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (final context) => AppLoading(color: color, size: size),
    );
  }

  static void hide() {
    if (isActive) {
      isActive = false;
      AppKeys.navigatorKey.currentState!.pop();
    }
  }
}
