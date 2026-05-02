import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/i18n/locale_provider.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class GetStartedContent extends StatelessWidget {
  const GetStartedContent({
    super.key,
    required this.onGetStarted,
    required this.onLogin,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Padding(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      child: Column(
        children: [
          const Spacer(flex: 1),
          const _HeroIllustration()
              .animate()
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),
          const SizedBox(height: ZolyaSpacing.xxl),
          Text(
            l.getStartedTitle,
            style: ZolyaTypography.displayMedium
                .copyWith(color: scheme.onSurface),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          const SizedBox(height: ZolyaSpacing.md),
          Text(
            l.getStartedSubtitle,
            style: ZolyaTypography.body.copyWith(color: mutedColor),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 350.ms, duration: 400.ms),
          const Spacer(flex: 2),
          ZolyaButton(
            label: l.getStartedCta,
            onPressed: onGetStarted,
            expand: true,
            size: ZolyaButtonSize.lg,
          ).animate().fadeIn(delay: 500.ms, duration: 300.ms).slideY(
                begin: 0.3,
                end: 0,
                delay: 500.ms,
                duration: 400.ms,
                curve: Curves.easeOut,
              ),
          const SizedBox(height: ZolyaSpacing.lg),
          _LoginLink(onTap: onLogin)
              .animate()
              .fadeIn(delay: 700.ms, duration: 300.ms),
          const SizedBox(height: ZolyaSpacing.sm),
        ],
      ),
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  const _HeroIllustration();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: ZolyaGradients.orNoir,
        borderRadius: BorderRadius.circular(ZolyaRadius.xl),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.18),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        'Z',
        style: ZolyaTypography.displayLarge.copyWith(
          color: Colors.white,
          fontSize: 110,
          height: 1,
        ),
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink({required this.onTap});
  final VoidCallback onTap;

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
          onTap: onTap,
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
