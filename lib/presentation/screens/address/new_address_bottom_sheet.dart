import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/map_preview.dart';

class NewAddressResult {
  const NewAddressResult({
    required this.nickname,
    required this.fullAddress,
    required this.isDefault,
  });
  final String nickname;
  final String fullAddress;
  final bool isDefault;
}

class NewAddressBottomSheet extends StatefulWidget {
  const NewAddressBottomSheet({super.key});

  static Future<NewAddressResult?> show(BuildContext context) {
    return showModalBottomSheet<NewAddressResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const NewAddressBottomSheet(),
      ),
    );
  }

  @override
  State<NewAddressBottomSheet> createState() => _NewAddressBottomSheetState();
}

class _NewAddressBottomSheetState extends State<NewAddressBottomSheet> {
  static const _nicknames = [
    'Home',
    'Office',
    'Apartment',
    "Parent's House",
    'Other',
  ];

  String? _nickname;
  final _addressCtrl = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _nickname != null && _addressCtrl.text.trim().isNotEmpty;

  void _submit() {
    if (!_canSubmit) return;
    Navigator.of(context).pop(NewAddressResult(
      nickname: _nickname!,
      fullAddress: _addressCtrl.text.trim(),
      isDefault: _isDefault,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(ZolyaRadius.xl)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            ZolyaSpacing.lg,
            ZolyaSpacing.sm + 2,
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
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(l.addressTitle, style: ZolyaTypography.headline),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(LucideIcons.x, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.md),
              MapPreview(
                height: 160,
                label: _addressCtrl.text.trim().isEmpty
                    ? null
                    : _addressCtrl.text.trim(),
                onTap: () {

                },
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              ZolyaSelect<String>(
                label: l.addressNicknameLabel,
                value: _nickname,
                placeholder: l.addressNicknameHint,
                options: [
                  for (final n in _nicknames)
                    ZolyaSelectOption(value: n, label: n),
                ],
                onChanged: (v) => setState(() => _nickname = v),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              ZolyaTextField(
                label: l.addressFullLabel,
                placeholder: l.addressFullHint,
                controller: _addressCtrl,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: ZolyaSpacing.md),
              ZolyaCheckbox(
                value: _isDefault,
                label: l.addressMakeDefault,
                onChanged: (v) => setState(() => _isDefault = v),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                label: l.addressAdd,
                onPressed: _canSubmit ? _submit : null,
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

Future<void> showAddressAddedDialog(BuildContext context) {
  final l = context.l10n;
  return ZolyaSuccessDialog.show(
    context,
    title: l.addressAddedTitle,
    message: l.addressAddedMessage,
    buttonLabel: l.addressThanks,
    onConfirm: () => Navigator.of(context).pop(),
  );
}
