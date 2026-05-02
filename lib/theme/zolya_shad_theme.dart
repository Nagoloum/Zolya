import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'zolya_theme.dart';

class ZolyaShadTheme {
  ZolyaShadTheme._();

  static ShadThemeData get light => ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadColorScheme(
          background: ZolyaColors.fond,
          foreground: ZolyaColors.texte1,
          card: ZolyaColors.surface,
          cardForeground: ZolyaColors.texte1,
          popover: ZolyaColors.surface,
          popoverForeground: ZolyaColors.texte1,
          primary: ZolyaColors.or,
          primaryForeground: ZolyaColors.noir,
          secondary: ZolyaColors.surface2,
          secondaryForeground: ZolyaColors.texte1,
          muted: ZolyaColors.surface2,
          mutedForeground: ZolyaColors.texte1,
          accent: ZolyaColors.or100,
          accentForeground: ZolyaColors.or900,
          destructive: ZolyaColors.erreur,
          destructiveForeground: ZolyaColors.blanc,
          border: ZolyaColors.texte1,
          input: ZolyaColors.texte1,
          ring: ZolyaColors.or,
          selection: ZolyaColors.or200,
        ),
        radius: const BorderRadius.all(Radius.circular(ZolyaRadius.sm)),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
      );

  static ShadThemeData get dark => ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadColorScheme(
          background: ZolyaColors.fondDark,
          foreground: ZolyaColors.texte1Dark,
          card: ZolyaColors.surfaceDark,
          cardForeground: ZolyaColors.texte1Dark,
          popover: ZolyaColors.surfaceDark,
          popoverForeground: ZolyaColors.texte1Dark,
          primary: ZolyaColors.or400,
          primaryForeground: ZolyaColors.noir,
          secondary: ZolyaColors.surface2Dark,
          secondaryForeground: ZolyaColors.texte1Dark,
          muted: ZolyaColors.surface2Dark,
          mutedForeground: ZolyaColors.texte1Dark,
          accent: ZolyaColors.or900,
          accentForeground: ZolyaColors.or100,
          destructive: Color(0xFFEF4444),
          destructiveForeground: ZolyaColors.blanc,
          border: ZolyaColors.texte1Dark,
          input: ZolyaColors.texte1Dark,
          ring: ZolyaColors.or400,
          selection: ZolyaColors.or700,
        ),
        radius: const BorderRadius.all(Radius.circular(ZolyaRadius.sm)),
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
      );
}
