import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _sending = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.contactUsSent)),
    );
    Navigator.of(context).maybePop();
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.shareSheetCopied)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.contactUsTitle, centerTitle: true),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(ZolyaSpacing.lg),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ContactTile(
                      icon: LucideIcons.mail,
                      label: l.contactUsEmailTile,
                      value: l.contactUsEmailAddress,
                      iconColor: scheme.primary,
                      onTap: () => _copyToClipboard(l.contactUsEmailAddress),
                    ),
                  ),
                  const SizedBox(width: ZolyaSpacing.sm),
                  Expanded(
                    child: _ContactTile(
                      icon: LucideIcons.phone,
                      label: l.contactUsPhoneTile,
                      value: l.contactUsPhoneNumber,
                      iconColor: scheme.primary,
                      onTap: () => _copyToClipboard(l.contactUsPhoneNumber),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Text(
                l.contactUsForm.toUpperCase(),
                style: ZolyaTypography.label.copyWith(
                  color: mutedColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              ZolyaTextField(
                controller: _nameCtrl,
                label: l.contactUsName,
                placeholder: l.contactUsName,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l.editProfileFieldRequired
                    : null,
              ),
              const SizedBox(height: ZolyaSpacing.md),
              ZolyaTextField(
                controller: _emailCtrl,
                label: l.contactUsEmail,
                placeholder: l.editProfileEmailHint,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l.editProfileFieldRequired
                    : null,
              ),
              const SizedBox(height: ZolyaSpacing.md),
              ZolyaTextField(
                controller: _subjectCtrl,
                label: l.contactUsSubject,
                placeholder: l.contactUsSubject,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l.editProfileFieldRequired
                    : null,
              ),
              const SizedBox(height: ZolyaSpacing.md),
              ZolyaTextarea(
                controller: _bodyCtrl,
                label: l.contactUsMessage,
                placeholder: l.contactUsMessage,
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                label: l.contactUsSend,
                leading: const Icon(LucideIcons.send, size: 18),
                onPressed: _sending ? null : _send,
                loading: _sending,
                expand: true,
                size: ZolyaButtonSize.lg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
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
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(height: ZolyaSpacing.sm),
              Text(
                label,
                style: ZolyaTypography.label
                    .copyWith(color: mutedColor, letterSpacing: 0.6),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ZolyaTypography.subtitle
                    .copyWith(color: scheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
