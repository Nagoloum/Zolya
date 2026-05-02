import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';

class ZolyaShareSheet extends StatelessWidget {
  const ZolyaShareSheet({
    super.key,
    required this.title,
    required this.shareUrl,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final String shareUrl;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String shareUrl,
    String? subtitle,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ZolyaShareSheet(
        title: title,
        shareUrl: shareUrl,
        subtitle: subtitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
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
                l.shareSheetTitle,
                style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ZolyaSpacing.xs),
              Text(
                title,
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _ShareOption(
                      icon: LucideIcons.messageCircle,
                      label: 'WhatsApp',
                      color: const Color(0xFF25D366),
                      onTap: () => _onShareTap(context, 'WhatsApp'),
                    ),
                    _ShareOption(
                      icon: LucideIcons.share2,
                      label: 'Facebook',
                      color: const Color(0xFF1877F2),
                      onTap: () => _onShareTap(context, 'Facebook'),
                    ),
                    _ShareOption(
                      icon: LucideIcons.camera,
                      label: 'Instagram',
                      color: const Color(0xFFE4405F),
                      onTap: () => _onShareTap(context, 'Instagram'),
                    ),
                    _ShareOption(
                      icon: LucideIcons.send,
                      label: 'Telegram',
                      color: const Color(0xFF0088CC),
                      onTap: () => _onShareTap(context, 'Telegram'),
                    ),
                    _ShareOption(
                      icon: LucideIcons.mail,
                      label: 'Email',
                      color: scheme.primary,
                      onTap: () => _onShareTap(context, 'Email'),
                    ),
                    _ShareOption(
                      icon: LucideIcons.messageSquare,
                      label: 'SMS',
                      color: mutedColor,
                      onTap: () => _onShareTap(context, 'SMS'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ZolyaSpacing.md,
                  vertical: ZolyaSpacing.sm + 2,
                ),
                decoration: BoxDecoration(
                  color: isLight
                      ? ZolyaColors.surface2
                      : ZolyaColors.surface2Dark,
                  borderRadius: BorderRadius.circular(ZolyaRadius.md),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Icon(LucideIcons.link, size: 18, color: mutedColor),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Expanded(
                      child: Text(
                        shareUrl,
                        style: ZolyaTypography.bodySmall
                            .copyWith(color: scheme.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onCopyTap(context),
                        borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Row(
                            children: [
                              Icon(LucideIcons.copy,
                                  size: 14, color: scheme.primary),
                              const SizedBox(width: 4),
                              Text(
                                l.shareSheetCopy,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onCopyTap(BuildContext context) async {
    final l = context.l10n;
    await Clipboard.setData(ClipboardData(text: shareUrl));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.shareSheetCopied)),
    );
    Navigator.of(context).maybePop();
  }

  void _onShareTap(BuildContext context, String channel) {
    final l = context.l10n;
    Navigator.of(context).maybePop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.shareSheetSoon(channel))),
    );
  }
}

class _ShareOption extends StatelessWidget {
  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final bgColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Padding(
      padding: const EdgeInsets.only(right: ZolyaSpacing.md),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
          child: Padding(
            padding: const EdgeInsets.all(ZolyaSpacing.xs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: ZolyaSpacing.sm),
                Text(
                  label,
                  style: ZolyaTypography.label.copyWith(
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
