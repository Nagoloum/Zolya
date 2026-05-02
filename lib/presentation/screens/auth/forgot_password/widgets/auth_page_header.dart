import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../theme/zolya_theme.dart';

class AuthPageHeader extends StatelessWidget {
  const AuthPageHeader({
    super.key,
    required this.title,
    required this.intro,
  });

  final String title;
  final String intro;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ZolyaTypography.displayMedium
              .copyWith(color: scheme.onSurface),
        ).animate().fadeIn(duration: 300.ms),
        const SizedBox(height: ZolyaSpacing.sm),
        Text(
          intro,
          style: ZolyaTypography.body.copyWith(color: mutedColor),
        ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
      ],
    );
  }
}
