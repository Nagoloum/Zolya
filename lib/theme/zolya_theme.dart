import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZolyaColors {
  ZolyaColors._();

  static const Color or          = Color(0xFFDE9E0C);
  static const Color noir        = Color(0xFF0A0A0A);
  static const Color blanc       = Color(0xFFFFFFFF);

  static const Color or50        = Color(0xFFFBF3DD);
  static const Color or100       = Color(0xFFF7E5B0);
  static const Color or200       = Color(0xFFF0D27C);
  static const Color or300       = Color(0xFFF2C24F);
  static const Color or400       = Color(0xFFE8AE26);
  static const Color or500       = Color(0xFFDE9E0C);
  static const Color or600       = Color(0xFFC58A0A);
  static const Color or700       = Color(0xFFA87708);
  static const Color or800       = Color(0xFF7A5606);
  static const Color or900       = Color(0xFF5C4104);

  static const Color fond        = Color(0xFFFAFAF8);
  static const Color surface     = Color(0xFFFFFFFF);
  static const Color surface2    = Color(0xFFF5F4F0);
  static const Color bordure     = Color(0xFFE5E2D8);
  static const Color texte1      = Color(0xFF1A1A1A);
  static const Color texte2      = Color(0xFF6B6B6B);
  static const Color texte3      = Color(0xFF999999);

  static const Color fondDark    = Color(0xFF0A0A0A);
  static const Color surfaceDark = Color(0xFF1C1C1C);
  static const Color surface2Dark= Color(0xFF242424);
  static const Color bordureDark = Color(0xFF2E2E2E);
  static const Color texte1Dark  = Color(0xFFFAFAF8);
  static const Color texte2Dark  = Color(0xFFB4B2A9);
  static const Color texte3Dark  = Color(0xFF6B6B6B);

  static const Color succes      = Color(0xFF16A34A);
  static const Color succesBg    = Color(0xFFEAF7EE);
  static const Color erreur      = Color(0xFFDC2626);
  static const Color erreurBg    = Color(0xFFFCEBEB);
  static const Color avertissement = Color(0xFFEA580C);
  static const Color avertissementBg = Color(0xFFFAECE7);
  static const Color info        = Color(0xFF2563EB);
  static const Color infoBg      = Color(0xFFE6F1FB);
}

class ZolyaGradients {
  ZolyaGradients._();

  static const LinearGradient or = LinearGradient(
    colors: [Color(0xFFE8AE26), Color(0xFFC58A0A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orSubtil = LinearGradient(
    colors: [Color(0xFFFBF3DD), Color(0xFFF7E5B0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient orNoir = LinearGradient(
    colors: [Color(0xFFDE9E0C), Color(0xFF0A0A0A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class ZolyaSpacing {
  ZolyaSpacing._();
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;
}

class ZolyaRadius {
  ZolyaRadius._();
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 999.0;
}

class ZolyaTypography {
  ZolyaTypography._();

  static TextStyle get displayLarge => GoogleFonts.montserrat(
        fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: -1, height: 1.1,
      );
  static TextStyle get displayMedium => GoogleFonts.montserrat(
        fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -0.5, height: 1.15,
      );
  static TextStyle get headline => GoogleFonts.montserrat(
        fontSize: 24, fontWeight: FontWeight.w800, height: 1.2,
      );
  static TextStyle get title => GoogleFonts.montserrat(
        fontSize: 18, fontWeight: FontWeight.w700, height: 1.3,
      );
  static TextStyle get subtitle => GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w600, height: 1.4,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 15, fontWeight: FontWeight.w400, height: 1.5,
      );
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 13, fontWeight: FontWeight.w400, height: 1.45,
      );
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.3, height: 1.4,
      );
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.6, height: 1.4,
      );

  static TextStyle get button => GoogleFonts.montserrat(
        fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.3,
      );
}

class ZolyaTheme {
  ZolyaTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: ZolyaColors.or,
      onPrimary: ZolyaColors.noir,
      primaryContainer: ZolyaColors.or100,
      onPrimaryContainer: ZolyaColors.or900,
      secondary: ZolyaColors.noir,
      onSecondary: ZolyaColors.blanc,
      secondaryContainer: ZolyaColors.surface2,
      onSecondaryContainer: ZolyaColors.texte1,
      tertiary: ZolyaColors.or700,
      onTertiary: ZolyaColors.blanc,
      error: ZolyaColors.erreur,
      onError: ZolyaColors.blanc,
      errorContainer: ZolyaColors.erreurBg,
      onErrorContainer: ZolyaColors.erreur,
      surface: ZolyaColors.surface,
      onSurface: ZolyaColors.texte1,
      surfaceContainerHighest: ZolyaColors.surface2,
      surfaceContainerHigh: ZolyaColors.surface2,
      surfaceContainer: ZolyaColors.fond,
      surfaceContainerLow: ZolyaColors.fond,
      surfaceContainerLowest: ZolyaColors.blanc,
      onSurfaceVariant: ZolyaColors.texte2,
      outline: ZolyaColors.bordure,
      outlineVariant: ZolyaColors.bordure,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: ZolyaColors.noir,
      onInverseSurface: ZolyaColors.blanc,
      inversePrimary: ZolyaColors.or300,
    );

    return _baseTheme(scheme).copyWith(
      scaffoldBackgroundColor: ZolyaColors.fond,
      dividerColor: ZolyaColors.bordure,
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: ZolyaColors.or400,
      onPrimary: ZolyaColors.noir,
      primaryContainer: ZolyaColors.or900,
      onPrimaryContainer: ZolyaColors.or100,
      secondary: ZolyaColors.blanc,
      onSecondary: ZolyaColors.noir,
      secondaryContainer: ZolyaColors.surface2Dark,
      onSecondaryContainer: ZolyaColors.texte1Dark,
      tertiary: ZolyaColors.or300,
      onTertiary: ZolyaColors.noir,
      error: Color(0xFFEF4444),
      onError: ZolyaColors.blanc,
      errorContainer: Color(0xFF601C1C),
      onErrorContainer: Color(0xFFFCBABA),
      surface: ZolyaColors.surfaceDark,
      onSurface: ZolyaColors.texte1Dark,
      surfaceContainerHighest: ZolyaColors.surface2Dark,
      surfaceContainerHigh: ZolyaColors.surface2Dark,
      surfaceContainer: ZolyaColors.surfaceDark,
      surfaceContainerLow: ZolyaColors.fondDark,
      surfaceContainerLowest: Color(0xFF000000),
      onSurfaceVariant: ZolyaColors.texte2Dark,
      outline: ZolyaColors.bordureDark,
      outlineVariant: ZolyaColors.bordureDark,
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: ZolyaColors.fond,
      onInverseSurface: ZolyaColors.texte1,
      inversePrimary: ZolyaColors.or700,
    );

    return _baseTheme(scheme).copyWith(
      scaffoldBackgroundColor: ZolyaColors.fondDark,
      dividerColor: ZolyaColors.bordureDark,
    );
  }

  static ThemeData _baseTheme(ColorScheme scheme) {
    final isLight = scheme.brightness == Brightness.light;
    final fg = scheme.onSurface;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final mutedFg = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final hintFg = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      iconTheme: IconThemeData(color: fg),
      primaryIconTheme: IconThemeData(color: fg),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: fg,
        selectionColor: scheme.primary.withValues(alpha: 0.25),
        selectionHandleColor: scheme.primary,
      ),
      textTheme: TextTheme(
        displayLarge: ZolyaTypography.displayLarge.copyWith(color: fg),
        displayMedium: ZolyaTypography.displayMedium.copyWith(color: fg),
        headlineMedium: ZolyaTypography.headline.copyWith(color: fg),
        titleLarge: ZolyaTypography.title.copyWith(color: fg),
        titleMedium: ZolyaTypography.subtitle.copyWith(color: fg),
        bodyLarge: ZolyaTypography.body.copyWith(color: fg),
        bodyMedium: ZolyaTypography.body.copyWith(color: fg),
        bodySmall: ZolyaTypography.bodySmall.copyWith(color: fg),
        labelLarge: ZolyaTypography.button.copyWith(color: scheme.onPrimary),
        labelMedium: ZolyaTypography.caption.copyWith(color: fg),
        labelSmall: ZolyaTypography.label.copyWith(color: fg),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: fg,
        iconTheme: IconThemeData(color: fg),
        actionsIconTheme: IconThemeData(color: fg),
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: ZolyaTypography.title.copyWith(color: fg),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          ),
          textStyle: ZolyaTypography.button,
          minimumSize: const Size(0, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(color: fg, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          ),
          textStyle: ZolyaTypography.button,
          minimumSize: const Size(0, 48),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: fg,
          textStyle: ZolyaTypography.button,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
          side: BorderSide(color: borderColor, width: 0.8),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIconColor: mutedFg,
        suffixIconColor: mutedFg,
        iconColor: mutedFg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          borderSide: BorderSide(color: scheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          borderSide: BorderSide.none,
        ),
        labelStyle: ZolyaTypography.body.copyWith(color: mutedFg),
        hintStyle: ZolyaTypography.body.copyWith(color: hintFg),
        floatingLabelStyle: ZolyaTypography.body.copyWith(color: fg),
        errorStyle: ZolyaTypography.bodySmall.copyWith(color: scheme.error),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: mutedFg,
        selectedLabelStyle: ZolyaTypography.caption,
        unselectedLabelStyle: ZolyaTypography.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 0.5,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        selectedColor: scheme.primaryContainer,
        labelStyle: ZolyaTypography.bodySmall.copyWith(color: fg),
        side: BorderSide(color: borderColor, width: 0.8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.full),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: borderColor,
        thickness: 0.5,
        space: 0,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: mutedFg,
        textColor: fg,
        contentPadding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.lg, vertical: ZolyaSpacing.xs),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(color: borderColor, width: 1.4),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return borderColor;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.onPrimary;
          return scheme.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return borderColor;
        }),
        trackOutlineColor: WidgetStateProperty.all(borderColor),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: ZolyaTypography.body.copyWith(color: scheme.onInverseSurface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.lg),
        ),
        titleTextStyle: ZolyaTypography.title.copyWith(color: fg),
        contentTextStyle: ZolyaTypography.body.copyWith(color: mutedFg),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(ZolyaRadius.xl)),
        ),
        showDragHandle: true,
        dragHandleColor: borderColor,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: mutedFg,
        labelStyle: ZolyaTypography.subtitle,
        unselectedLabelStyle: ZolyaTypography.subtitle,
        indicatorColor: scheme.primary,
        dividerColor: borderColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
        ),
        textStyle: ZolyaTypography.bodySmall.copyWith(color: scheme.onInverseSurface),
      ),
    );
  }
}
