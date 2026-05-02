import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/theme/theme_cubit.dart';

class ZolyaThemeSheet extends StatelessWidget {
  const ZolyaThemeSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const ZolyaThemeSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;

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
                l.menuTheme,
                textAlign: TextAlign.center,
                style:
                    ZolyaTypography.title.copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: ZolyaSpacing.xs),
              Text(
                l.settingsAppearance,
                textAlign: TextAlign.center,
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, mode) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ThemeOption(
                        icon: LucideIcons.sun,
                        label: l.settingsThemeLight,
                        selected: mode == ThemeMode.light,
                        onTap: () => context
                            .read<ThemeCubit>()
                            .setMode(ThemeMode.light),
                      ),
                      const SizedBox(height: ZolyaSpacing.sm),
                      _ThemeOption(
                        icon: LucideIcons.moon,
                        label: l.settingsThemeDark,
                        selected: mode == ThemeMode.dark,
                        onTap: () => context
                            .read<ThemeCubit>()
                            .setMode(ThemeMode.dark),
                      ),
                      const SizedBox(height: ZolyaSpacing.sm),
                      _ThemeOption(
                        icon: LucideIcons.monitor,
                        label: l.settingsThemeSystem,
                        selected: mode == ThemeMode.system,
                        onTap: () => context
                            .read<ThemeCubit>()
                            .setMode(ThemeMode.system),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
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
              Icon(icon, size: 20,
                  color: selected ? scheme.primary : scheme.onSurface),
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
