import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final _subjectCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _sending = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message envoyé. Réponse sous 24h.')),
    );
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'Contact us', centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          children: [
            Row(
              children: [
                Expanded(
                  child: _ContactTile(
                    icon: LucideIcons.phone,
                    label: 'Call',
                    detail: '+237 6 99 00 00 00',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: ZolyaSpacing.sm),
                Expanded(
                  child: _ContactTile(
                    icon: LucideIcons.messageCircle,
                    label: 'WhatsApp',
                    detail: 'Chat 24/7',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            Text(
              'SEND A MESSAGE',
              style: ZolyaTypography.label.copyWith(
                color: mutedColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            ZolyaTextField(
              controller: _subjectCtrl,
              label: 'Subject',
              placeholder: 'Décrivez brièvement le problème',
            ),
            const SizedBox(height: ZolyaSpacing.md),
            ZolyaTextarea(
              controller: _bodyCtrl,
              label: 'Message',
              placeholder: 'Dites-nous tout. Réponse sous 24h ouvrées.',
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            ZolyaButton(
              label: 'Send',
              leading: const Icon(LucideIcons.send, size: 18),
              onPressed: _sending ? null : _send,
              loading: _sending,
              expand: true,
              size: ZolyaButtonSize.lg,
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            Container(
              padding: const EdgeInsets.all(ZolyaSpacing.md),
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(ZolyaRadius.md),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(LucideIcons.info, size: 16, color: scheme.primary),
                  const SizedBox(width: ZolyaSpacing.sm),
                  Expanded(
                    child: Text(
                      'Une question rapide ? Consultez d\'abord la FAQ : '
                      'la plupart des réponses s\'y trouvent.',
                      style: ZolyaTypography.bodySmall
                          .copyWith(color: mutedColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.detail,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: scheme.primary, size: 24),
              const SizedBox(height: ZolyaSpacing.sm),
              Text(
                label,
                style: ZolyaTypography.subtitle
                    .copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
