import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  static const String _code = 'AMINATA-23';
  static const String _shareLink = 'https://zolya.app/invite/AMINATA-23';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'Invite friends', centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          children: [
            const SizedBox(height: ZolyaSpacing.lg),
            ZolyaGradientCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.gift,
                          color: ZolyaColors.noir, size: 20),
                      const SizedBox(width: ZolyaSpacing.sm),
                      Text(
                        'Earn 1 000 FCFA',
                        style: ZolyaTypography.subtitle.copyWith(
                          color: ZolyaColors.noir,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ZolyaSpacing.sm),
                  Text(
                    'Share your code with a friend. When they complete '
                    'their first transaction, you each receive 1 000 FCFA '
                    'in your Zolya wallet.',
                    style: ZolyaTypography.body.copyWith(
                      color: ZolyaColors.noir.withValues(alpha: 0.85),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            Text(
              'YOUR REFERRAL CODE',
              style: ZolyaTypography.label.copyWith(
                color: mutedColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: ZolyaSpacing.lg,
                vertical: ZolyaSpacing.md + 2,
              ),
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(ZolyaRadius.md),
                border: Border.all(color: borderColor, width: 1.2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _code,
                      style: ZolyaTypography.headline.copyWith(
                        color: scheme.onSurface,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _copy(context, _code),
                      borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ZolyaSpacing.md,
                          vertical: ZolyaSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Icon(LucideIcons.copy,
                                size: 16, color: scheme.primary),
                            const SizedBox(width: ZolyaSpacing.xs),
                            Text(
                              'Copy',
                              style: ZolyaTypography.bodySmall.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            ZolyaButton(
              label: 'Share code',
              leading: const Icon(LucideIcons.share2, size: 18),
              onPressed: () => ZolyaShareSheet.show(
                context,
                title: 'Join me on Zolya',
                shareUrl: _shareLink,
                subtitle: 'Referral code $_code',
              ),
              expand: true,
              size: ZolyaButtonSize.lg,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            Text(
              'YOUR REFERRALS',
              style: ZolyaTypography.label.copyWith(
                color: mutedColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _ReferralStat(
                    value: '3',
                    label: 'friends signed up',
                    mutedColor: mutedColor,
                    fillColor: fillColor,
                    scheme: scheme,
                  ),
                ),
                const SizedBox(width: ZolyaSpacing.sm),
                Expanded(
                  child: _ReferralStat(
                    value: '2 000 FCFA',
                    label: 'earned',
                    mutedColor: mutedColor,
                    fillColor: fillColor,
                    scheme: scheme,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code copied')),
    );
  }
}

class _ReferralStat extends StatelessWidget {
  const _ReferralStat({
    required this.value,
    required this.label,
    required this.mutedColor,
    required this.fillColor,
    required this.scheme,
  });
  final String value;
  final String label;
  final Color mutedColor;
  final Color fillColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: ZolyaTypography.title.copyWith(color: scheme.primary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: ZolyaTypography.label.copyWith(color: mutedColor),
          ),
        ],
      ),
    );
  }
}
