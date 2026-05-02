import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';

class ZolyaLanguageSheet extends StatelessWidget {
  const ZolyaLanguageSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const ZolyaLanguageSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final l = context.l10n;
    final current = context.appLocale;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ZolyaRadius.xl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            ZolyaSpacing.lg,
            ZolyaSpacing.md,
            ZolyaSpacing.lg,
            ZolyaSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: ZolyaSpacing.lg),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Text(
                l.menuLanguage,
                textAlign: TextAlign.center,
                style:
                    ZolyaTypography.title.copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              _LanguageOption(
                flag: '🇬🇧',
                label: l.settingsLanguageEnglish,
                selected: current == AppLocale.en,
                onTap: () {
                  LocaleProvider.setLocale(context, AppLocale.en);
                  Navigator.of(context).maybePop();
                },
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              _LanguageOption(
                flag: '🇫🇷',
                label: l.settingsLanguageFrench,
                selected: current == AppLocale.fr,
                onTap: () {
                  LocaleProvider.setLocale(context, AppLocale.fr);
                  Navigator.of(context).maybePop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String flag;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: ZolyaSpacing.lg,
            vertical: ZolyaSpacing.md,
          ),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary.withValues(alpha: 0.08)
                : scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            border: Border.all(
              color: selected ? scheme.primary : borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: ZolyaSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: ZolyaTypography.subtitle.copyWith(
                    color: selected ? scheme.primary : scheme.onSurface,
                  ),
                ),
              ),
              if (selected)
                Icon(LucideIcons.check, size: 18, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
