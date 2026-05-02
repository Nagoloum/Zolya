import 'package:flutter/material.dart';

import '../../../../core/i18n/locale_provider.dart';
import '../../../../theme/zolya_theme.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key, required this.onLoginTap});
  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l.alreadyHaveAccount,
          style: ZolyaTypography.body.copyWith(color: mutedColor),
        ),
        const SizedBox(width: ZolyaSpacing.xs),
        GestureDetector(
          onTap: onLoginTap,
          child: Text(
            l.logIn,
            style: ZolyaTypography.body.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
