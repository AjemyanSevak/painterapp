import 'package:flutter/material.dart';
import 'package:painter_app/base/colors/app_colors.dart';
import 'package:painter_app/base/text_styles.dart';

class AppThemes {
  static const String fontFamily = 'Poppins';

  static ThemeData get appTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      cardColor: AppColors.white,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateColor.resolveWith((states) => AppColors.primary),
      ),
      fontFamily: fontFamily,
      primaryTextTheme: const TextTheme(
        displayLarge: AppTextStyles.display1,
        displayMedium: AppTextStyles.display2,
        displaySmall: AppTextStyles.display3,
        headlineLarge: AppTextStyles.display4,
        headlineMedium: AppTextStyles.h2,
        headlineSmall: AppTextStyles.h3,
        titleLarge: AppTextStyles.h4,
        titleMedium: AppTextStyles.h5,
        titleSmall: AppTextStyles.h6,
        labelLarge: AppTextStyles.h7,
        labelMedium: AppTextStyles.h8,
        bodyLarge: AppTextStyles.bodyLargeRegular,
        bodyMedium: AppTextStyles.bodyMediumRegular,
        bodySmall: AppTextStyles.bodySmallRegular,
        labelSmall: AppTextStyles.extraSmallRegular,
      ),
      colorScheme: ColorScheme.fromSwatch(
        errorColor: AppColors.red,
      ).copyWith(primary: AppColors.primary, secondary: AppColors.secondary),
    );
  }
}
