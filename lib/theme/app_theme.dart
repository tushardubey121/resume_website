import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const ink = Color(0xFF101820);
  static const inkSoft = Color(0xFF3A4650);
  static const mist = Color(0xFFF3F6F8);
  static const mistDeep = Color(0xFFE4EBEF);
  static const foam = Color(0xFFFAFCFD);
  static const accent = Color(0xFF0F766E);
  static const accentSoft = Color(0xFF14B8A6);
  static const line = Color(0xFFD5DEE5);
  static const white = Color(0xFFFFFFFF);
}

abstract final class AppTheme {
  static ThemeData light() {
    final display = GoogleFonts.fraunces(
      color: AppColors.ink,
      fontWeight: FontWeight.w600,
      height: 1.1,
      letterSpacing: -0.5,
    );
    final body = GoogleFonts.figtree(
      color: AppColors.inkSoft,
      height: 1.55,
      letterSpacing: 0.1,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.foam,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        onPrimary: AppColors.white,
        secondary: AppColors.accentSoft,
        surface: AppColors.foam,
        onSurface: AppColors.ink,
      ),
      textTheme: TextTheme(
        displayLarge: display.copyWith(fontSize: 72),
        displayMedium: display.copyWith(fontSize: 52),
        displaySmall: display.copyWith(fontSize: 40),
        headlineLarge: display.copyWith(fontSize: 36),
        headlineMedium: display.copyWith(fontSize: 28),
        headlineSmall: display.copyWith(fontSize: 22),
        titleLarge: body.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        titleMedium: body.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        bodyLarge: body.copyWith(fontSize: 18),
        bodyMedium: body.copyWith(fontSize: 16),
        bodySmall: body.copyWith(fontSize: 14, color: AppColors.inkSoft),
        labelLarge: body.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: AppColors.ink,
        ),
      ),
    );
  }
}

abstract final class Breakpoints {
  static const phone = 600.0;
  static const tablet = 920.0;
  static const desktop = 1100.0;
}

extension ResponsiveContext on BuildContext {
  double get pageWidth => MediaQuery.sizeOf(this).width;

  bool get isPhone => pageWidth < Breakpoints.phone;

  bool get isCompact => pageWidth < Breakpoints.tablet;

  bool get isDesktop => pageWidth >= Breakpoints.desktop;

  double get contentMaxWidth => isDesktop ? 1120 : 920;

  EdgeInsets get pagePadding => EdgeInsets.symmetric(
        horizontal: isPhone ? 20 : (isCompact ? 28 : (isDesktop ? 48 : 32)),
      );

  EdgeInsets get sectionPadding => pagePadding.copyWith(
        top: isPhone ? 56 : 88,
        bottom: isPhone ? 56 : 88,
      );

  double get sectionGap => isPhone ? 28 : 40;

  double get blockGap => isPhone ? 32 : 48;
}
