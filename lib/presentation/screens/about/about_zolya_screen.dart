import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class AboutZolyaScreen extends StatelessWidget {
  const AboutZolyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'About', centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          children: [
            const SizedBox(height: ZolyaSpacing.lg),
            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: ZolyaGradients.or,
                  borderRadius: BorderRadius.circular(ZolyaRadius.xl),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Z',
                  style: ZolyaTypography.displayLarge.copyWith(
                    color: ZolyaColors.noir,
                    fontSize: 56,
                    height: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            Center(
              child: Text(
                'ZOLYA',
                style: ZolyaTypography.displayMedium.copyWith(
                  color: scheme.onSurface,
                  letterSpacing: 6,
                ),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xs),
            Center(
              child: Text(
                'Second-hand fashion marketplace · Douala',
                style: ZolyaTypography.body.copyWith(color: mutedColor),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xxl),
            Text(
              'Zolya gives a second life to clothes, accessories and shoes '
              'through a marketplace designed for Cameroon. Buy and sell '
              'safely thanks to our Mobile Money escrow payment and our '
              'local zone-based delivery.',
              style: ZolyaTypography.body.copyWith(
                color: mutedColor,
                height: 1.6,
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            const _Stat(
              icon: LucideIcons.users,
              value: '12 500+',
              label: 'active users',
            ),
            const _Stat(
              icon: LucideIcons.shoppingBag,
              value: '34 000+',
              label: 'articles published',
            ),
            const _Stat(
              icon: LucideIcons.shieldCheck,
              value: '98%',
              label: 'secure transactions',
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            Text(
              'INFORMATION',
              style: ZolyaTypography.label.copyWith(
                color: mutedColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            ZolyaListTile(
              leading: Icon(LucideIcons.fileText, color: mutedColor, size: 20),
              title: 'Terms of use',
              onTap: () => context.push(RouteNames.legalTerms),
            ),
            ZolyaListTile(
              leading: Icon(LucideIcons.shield, color: mutedColor, size: 20),
              title: 'Privacy policy',
              onTap: () => context.push(RouteNames.legalPrivacy),
            ),
            ZolyaListTile(
              leading: Icon(LucideIcons.cookie, color: mutedColor, size: 20),
              title: 'Cookies',
              onTap: () => context.push(RouteNames.legalCookies),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            Center(
              child: Text(
                'Zolya v1.0.0 · build 1',
                style: ZolyaTypography.label.copyWith(color: mutedColor),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xs),
            Center(
              child: Text(
                '© 2026 Zolya · Made with ❤ in Douala',
                style: ZolyaTypography.label.copyWith(color: mutedColor),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: ZolyaSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(ZolyaRadius.sm),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: scheme.primary, size: 20),
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Text(
            value,
            style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
          ),
          const SizedBox(width: ZolyaSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: ZolyaTypography.body.copyWith(color: mutedColor),
            ),
          ),
        ],
      ),
    );
  }
}
