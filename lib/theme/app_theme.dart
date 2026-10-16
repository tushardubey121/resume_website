import 'package:flutter/material.dart';

abstract final class AppColors {
  static const paper = Color(0xFFF6F5F1);
  static const surface = Color(0xFFFFFFFF);
  static const sunken = Color(0xFFEEECE6);
  static const ink = Color(0xFF14171A);
  static const inkMuted = Color(0xFF454D55);
  static const inkSubtle = Color(0xFF5C646C);
  static const line = Color(0xFFDDD9CF);
  static const lineStrong = Color(0xFFC4BEB1);

  static const accent = Color(0xFF0B6B61);
  static const accentStrong = Color(0xFF07524A);
  static const accentTint = Color(0xFFE1EEEA);

  static const night = Color(0xFF111518);
  static const nightRaised = Color(0xFF1A1F23);
  static const nightLine = Color(0xFF2C3338);
  static const nightText = Color(0xFFEDEBE5);
  static const nightMuted = Color(0xFFA7AFB5);
  static const nightAccent = Color(0xFF6FCBBE);

  static const focusRing = Color(0xFF0B6B61);
  static const available = Color(0xFF1F9D57);

  // Project plates, sampled from each project's own brand artwork.
  static const plateSpice = Color(0xFF5B2A6E);
  static const plateTeplo = Color(0xFF000000);
  static const plateTravelUnion = Color(0xFFF15B3A);
  static const plateFoodaholix = Color(0xFFF4EEE2);
  static const plateNeutral = Color(0xFFE6E2D8);
  static const plateHaulink = Color(0xFF199D88);
  static const plateJournies = Color(0xFFF6ECE6);
  static const plateArgo = Color(0xFF9FE2FF);
}

abstract final class AppFonts {
  static const display = 'Fraunces';
  static const body = 'Figtree';
  static const mono = 'JetBrainsMono';
}

abstract final class Space {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double x2 = 32;
  static const double x3 = 48;
  static const double x4 = 64;
  static const double x5 = 96;
}

abstract final class Breakpoints {
  static const phone = 600.0;
  static const tablet = 920.0;
  static const desktop = 1100.0;
}

abstract final class Motion {
  static const fast = Duration(milliseconds: 160);
  static const medium = Duration(milliseconds: 280);
  static const curve = Curves.easeOutCubic;
}

extension ResponsiveContext on BuildContext {
  double get pageWidth => MediaQuery.sizeOf(this).width;

  bool get isPhone => pageWidth < Breakpoints.phone;

  bool get isCompact => pageWidth < Breakpoints.tablet;

  bool get isDesktop => pageWidth >= Breakpoints.desktop;

  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);

  double get contentMaxWidth => 1180;

  /// Width of the left editorial rail that holds section labels and dates.
  double get railWidth => isDesktop ? 260 : 200;

  EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: isPhone ? 20 : (isCompact ? 32 : 48));

  EdgeInsets get sectionPadding => pagePadding.copyWith(
    top: isPhone ? Space.x4 : Space.x5 + Space.x2,
    bottom: isPhone ? Space.x4 : Space.x5 + Space.x2,
  );

  double get sectionGap => isPhone ? Space.x2 : Space.x3 + Space.lg;
}

/// The type scale. Every text style in the UI comes from here.
extension AppTextStyles on BuildContext {
  TextStyle get display {
    final size = isPhone ? 38.0 : (isCompact ? 50.0 : 64.0);
    return TextStyle(
      fontFamily: AppFonts.display,
      fontSize: size,
      fontWeight: FontWeight.w500,
      height: 1.06,
      letterSpacing: -0.025 * size,
      color: AppColors.ink,
    );
  }

  TextStyle get h1 {
    final size = isPhone ? 30.0 : (isCompact ? 36.0 : 44.0);
    return TextStyle(
      fontFamily: AppFonts.display,
      fontSize: size,
      fontWeight: FontWeight.w500,
      height: 1.12,
      letterSpacing: -0.02 * size,
      color: AppColors.ink,
    );
  }

  TextStyle get h2 {
    final size = isPhone ? 26.0 : (isCompact ? 30.0 : 34.0);
    return TextStyle(
      fontFamily: AppFonts.display,
      fontSize: size,
      fontWeight: FontWeight.w500,
      height: 1.15,
      letterSpacing: -0.015 * size,
      color: AppColors.ink,
    );
  }

  TextStyle get h3 {
    final size = isPhone ? 21.0 : 24.0;
    return TextStyle(
      fontFamily: AppFonts.display,
      fontSize: size,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: -0.01 * size,
      color: AppColors.ink,
    );
  }

  TextStyle get h4 => TextStyle(
    fontFamily: AppFonts.body,
    fontSize: isPhone ? 16.5 : 17.5,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: AppColors.ink,
  );

  TextStyle get lead => TextStyle(
    fontFamily: AppFonts.body,
    fontSize: isPhone ? 17.0 : (isCompact ? 18.0 : 19.5),
    fontWeight: FontWeight.w400,
    height: 1.55,
    color: AppColors.inkMuted,
  );

  TextStyle get body => TextStyle(
    fontFamily: AppFonts.body,
    fontSize: isPhone ? 15.5 : 16.5,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.inkMuted,
  );

  TextStyle get bodySmall => TextStyle(
    fontFamily: AppFonts.body,
    fontSize: isPhone ? 14.0 : 14.5,
    fontWeight: FontWeight.w400,
    height: 1.55,
    color: AppColors.inkSubtle,
  );

  TextStyle get button => const TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.1,
    color: AppColors.ink,
  );

  /// Monospaced metadata: section indices, dates, captions, stack tags.
  TextStyle get mono => const TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.2,
    color: AppColors.inkSubtle,
  );

  TextStyle get monoSmall => const TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: 11.5,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.2,
    color: AppColors.inkSubtle,
  );

  /// Uppercase mono label used for eyebrows and field names.
  TextStyle get eyebrow => const TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1.1,
    color: AppColors.accent,
  );
}

abstract final class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppFonts.body,
      scaffoldBackgroundColor: AppColors.paper,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        onPrimary: AppColors.surface,
        secondary: AppColors.accentStrong,
        surface: AppColors.paper,
        onSurface: AppColors.ink,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.accent.withValues(alpha: 0.22),
        cursorColor: AppColors.accent,
      ),
      focusColor: AppColors.focusRing.withValues(alpha: 0.12),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.body,
          fontSize: 13,
          color: AppColors.paper,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: TextStyle(
          fontFamily: AppFonts.body,
          fontSize: 14,
          color: AppColors.paper,
        ),
      ),
    );
  }
}
