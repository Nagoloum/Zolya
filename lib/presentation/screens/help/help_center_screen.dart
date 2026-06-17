import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

/// Hub regroupant les différents canaux d'aide (FAQ, assistant, contact).
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.helpCenterTitle, centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          children: [
            Text(
              l.helpCenterIntro,
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            _HelpTile(
              icon: LucideIcons.info,
              title: l.helpCenterFaqTitle,
              subtitle: l.helpCenterFaqSubtitle,
              onTap: () => context.push(RouteNames.faq),
              mutedColor: mutedColor,
              scheme: scheme,
              isLight: isLight,
            ),
            const SizedBox(height: ZolyaSpacing.md),
            _HelpTile(
              icon: LucideIcons.messageCircle,
              title: l.customerServiceTitle,
              subtitle: l.helpCenterChatSubtitle,
              onTap: () => context.push(RouteNames.customerService),
              mutedColor: mutedColor,
              scheme: scheme,
              isLight: isLight,
            ),
            const SizedBox(height: ZolyaSpacing.md),
            _HelpTile(
              icon: LucideIcons.mail,
              title: l.contactUsTitle,
              subtitle: l.helpCenterContactSubtitle,
              onTap: () => context.push(RouteNames.contactUs),
              mutedColor: mutedColor,
              scheme: scheme,
              isLight: isLight,
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.mutedColor,
    required this.scheme,
    required this.isLight,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color mutedColor;
  final ColorScheme scheme;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: Container(
          padding: const EdgeInsets.all(ZolyaSpacing.md),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                ),
                child: Icon(icon, color: scheme.primary, size: 22),
              ),
              const SizedBox(width: ZolyaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: ZolyaTypography.subtitle
                          .copyWith(color: scheme.onSurface),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style:
                          ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                    ),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight, size: 18, color: mutedColor),
            ],
          ),
        ),
      ),
    );
  }
}
