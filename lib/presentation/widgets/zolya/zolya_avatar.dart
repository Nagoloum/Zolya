import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

enum ZolyaAvatarSize { sm, md, lg, xl }

class ZolyaAvatar extends StatelessWidget {
  const ZolyaAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = ZolyaAvatarSize.md,
    this.diameter,
    this.useGradient = true,
  });

  final String? imageUrl;
  final String? name;
  final ZolyaAvatarSize size;
  final double? diameter;
  final bool useGradient;

  double get _effectiveDiameter {
    if (diameter != null) return diameter!;
    return switch (size) {
      ZolyaAvatarSize.sm => 32,
      ZolyaAvatarSize.md => 48,
      ZolyaAvatarSize.lg => 72,
      ZolyaAvatarSize.xl => 96,
    };
  }

  TextStyle _textStyle(BuildContext context) {
    final fontSize = switch (size) {
      ZolyaAvatarSize.sm => 13.0,
      ZolyaAvatarSize.md => 18.0,
      ZolyaAvatarSize.lg => 28.0,
      ZolyaAvatarSize.xl => 36.0,
    };
    final scheme = Theme.of(context).colorScheme;
    final color = useGradient ? scheme.onPrimary : scheme.onSurface;
    return ZolyaTypography.headline.copyWith(
      color: color,
      fontSize: fontSize,
      height: 1,
    );
  }

  String get _initial {
    final n = name?.trim();
    if (n == null || n.isEmpty) return '?';
    return n[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final d = _effectiveDiameter;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: d,
          height: d,
          fit: BoxFit.cover,
          placeholder: (_, __) => _Fallback(
            initial: _initial,
            diameter: d,
            useGradient: useGradient,
            textStyle: _textStyle(context),
          ),
          errorWidget: (_, __, ___) => _Fallback(
            initial: _initial,
            diameter: d,
            useGradient: useGradient,
            textStyle: _textStyle(context),
          ),
        ),
      );
    }
    return _Fallback(
      initial: _initial,
      diameter: d,
      useGradient: useGradient,
      textStyle: _textStyle(context),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({
    required this.initial,
    required this.diameter,
    required this.useGradient,
    required this.textStyle,
  });
  final String initial;
  final double diameter;
  final bool useGradient;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final fallbackBg =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: useGradient ? null : fallbackBg,
        gradient: useGradient ? ZolyaGradients.or : null,
      ),
      alignment: Alignment.center,
      child: Text(initial, style: textStyle),
    );
  }
}
