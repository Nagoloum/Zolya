import 'package:flutter/material.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/language_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final locale = context.appLocale;
    final theme = Theme.of(context);
    final mutedColor = theme.brightness == Brightness.light
        ? ZolyaColors.texte2
        : ZolyaColors.texte2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.settingsTitle, centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: ZolyaSpacing.lg,
            vertical: ZolyaSpacing.lg,
          ),
          children: [
            _SectionHeader(
              title: l.settingsLanguage,
              mutedColor: mutedColor,
            ),
            const SizedBox(height: ZolyaSpacing.md),
            LanguageSelector(
              current: locale,
              englishLabel: l.settingsLanguageEnglish,
              frenchLabel: l.settingsLanguageFrench,
              onChanged: (loc) => LocaleProvider.setLocale(context, loc),
            ),
            const SizedBox(height: ZolyaSpacing.xxl),
            _SectionHeader(
              title: l.settingsAppearance,
              mutedColor: mutedColor,
            ),
            const SizedBox(height: ZolyaSpacing.md),
            ZolyaThemeSwitcher(
              lightLabel: l.settingsThemeLight,
              darkLabel: l.settingsThemeDark,
              systemLabel: l.settingsThemeSystem,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.mutedColor,
  });

  final String title;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: ZolyaSpacing.xs),
      child: Text(
        title.toUpperCase(),
        style: ZolyaTypography.label.copyWith(color: mutedColor),
      ),
    );
  }
}
