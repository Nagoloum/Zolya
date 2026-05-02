import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

enum ZolyaSocialProvider { google, apple }

class ZolyaSocialButton extends StatelessWidget {
  const ZolyaSocialButton({
    super.key,
    required this.provider,
    required this.label,
    this.onPressed,
  });

  final ZolyaSocialProvider provider;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final isGoogle = provider == ZolyaSocialProvider.google;

    final borderNeutral =
        isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    final Color bg;
    final Color fg;
    final Color border;
    if (isGoogle) {
      bg = scheme.surfaceContainerLowest;
      fg = scheme.onSurface;
      border = borderNeutral;
    } else {
      bg = scheme.onSurface;
      fg = scheme.surface;
      border = scheme.onSurface;
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ProviderIcon(provider: provider, color: fg),
            const SizedBox(width: ZolyaSpacing.md),
            Text(label, style: ZolyaTypography.button.copyWith(color: fg)),
          ],
        ),
      ),
    );
  }
}

class _ProviderIcon extends StatelessWidget {
  const _ProviderIcon({required this.provider, required this.color});
  final ZolyaSocialProvider provider;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return switch (provider) {
      ZolyaSocialProvider.google => _GoogleMark(color: color),
      ZolyaSocialProvider.apple =>
        Icon(LucideIcons.apple, color: color, size: 20),
    };
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        shape: BoxShape.circle,
      ),
      child: Text(
        'G',
        style: ZolyaTypography.subtitle.copyWith(
          color: color,
          fontSize: 13,
          height: 1,
        ),
      ),
    );
  }
}
