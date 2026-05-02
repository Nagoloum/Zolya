import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';
import '../../bloc/theme/theme_cubit.dart';

class ZolyaThemeSwitcher extends StatelessWidget {
  const ZolyaThemeSwitcher({
    super.key,
    this.lightLabel = 'Light',
    this.darkLabel = 'Dark',
    this.systemLabel = 'System',
  });

  final String lightLabel;
  final String darkLabel;
  final String systemLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ThemeOption(
              icon: LucideIcons.sun,
              label: lightLabel,
              selected: mode == ThemeMode.light,
              onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.light),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            _ThemeOption(
              icon: LucideIcons.moon,
              label: darkLabel,
              selected: mode == ThemeMode.dark,
              onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.dark),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            _ThemeOption(
              icon: LucideIcons.monitor,
              label: systemLabel,
              selected: mode == ThemeMode.system,
              onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.system),
            ),
          ],
        );
      },
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
              Icon(
                icon,
                size: 20,
                color: selected ? scheme.primary : scheme.onSurface,
              ),
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
