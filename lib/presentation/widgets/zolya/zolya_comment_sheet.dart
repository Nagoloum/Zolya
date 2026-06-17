import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import 'zolya_async_button.dart';
import 'zolya_button.dart';

class ZolyaCommentSheet extends StatefulWidget {
  const ZolyaCommentSheet({
    super.key,
    required this.onSubmit,
  });

  final void Function(String text, int rating) onSubmit;

  static Future<void> show(
    BuildContext context, {
    required void Function(String text, int rating) onSubmit,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: ZolyaCommentSheet(onSubmit: onSubmit),
      ),
    );
  }

  @override
  State<ZolyaCommentSheet> createState() => _ZolyaCommentSheetState();
}

class _ZolyaCommentSheetState extends State<ZolyaCommentSheet> {
  final _controller = TextEditingController();
  String _text = '';
  int _rating = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final trimmed = _text.trim();
    if (trimmed.isEmpty) return;
    final confirmed = await _showValidationDialog(context);
    if (confirmed != true || !mounted) return;
    widget.onSubmit(trimmed, _rating);
    Navigator.of(context).maybePop();
  }

  Future<bool?> _showValidationDialog(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return showDialog<bool>(
      context: context,
      builder: (dialogCtx) => Dialog(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZolyaRadius.lg),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.xxl,
          vertical: ZolyaSpacing.xl,
        ),
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(LucideIcons.messageSquareText,
                      color: scheme.primary, size: 28),
                ),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Text(
                l.commentsValidationTitle,
                textAlign: TextAlign.center,
                style:
                    ZolyaTypography.title.copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              Text(
                l.commentsValidationMessage,
                textAlign: TextAlign.center,
                style: ZolyaTypography.body.copyWith(color: mutedColor),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: ZolyaButton(
                      variant: ZolyaButtonVariant.outline,
                      label: l.commentsValidationCancel,
                      onPressed: () => Navigator.of(dialogCtx).pop(false),
                      expand: true,
                    ),
                  ),
                  const SizedBox(width: ZolyaSpacing.sm),
                  Expanded(
                    child: ZolyaButton(
                      label: l.commentsValidationConfirm,
                      onPressed: () => Navigator.of(dialogCtx).pop(true),
                      expand: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final l = context.l10n;
    final canSubmit = _text.trim().isNotEmpty;

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
                l.commentsAddCta,
                textAlign: TextAlign.center,
                style:
                    ZolyaTypography.title.copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Text(
                _rating > 0 ? l.commentsRatingLabel : l.commentsRatingTapToRate,
                textAlign: TextAlign.center,
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final star = i + 1;
                  final filled = _rating >= star;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _rating = _rating == star ? 0 : star;
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ZolyaSpacing.xs),
                      child: Icon(
                        filled ? LucideIcons.star : LucideIcons.star,
                        size: 32,
                        color: filled
                            ? scheme.primary
                            : (isLight
                                ? ZolyaColors.bordure
                                : ZolyaColors.bordureDark),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ZolyaSpacing.md,
                  vertical: ZolyaSpacing.sm + 2,
                ),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(ZolyaRadius.md),
                ),
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  cursorColor: scheme.onSurface,
                  minLines: 3,
                  maxLines: 6,
                  maxLength: 500,
                  style:
                      ZolyaTypography.body.copyWith(color: scheme.onSurface),
                  decoration: InputDecoration.collapsed(
                    hintText: l.commentsHint,
                    hintStyle:
                        ZolyaTypography.body.copyWith(color: mutedColor),
                  ),
                  onChanged: (v) => setState(() => _text = v),
                ),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              ZolyaAsyncButton(
                label: l.commentsValidationConfirm,
                leading: const Icon(LucideIcons.send, size: 18),
                onPressed: _handleSubmit,
                enabled: canSubmit,
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
