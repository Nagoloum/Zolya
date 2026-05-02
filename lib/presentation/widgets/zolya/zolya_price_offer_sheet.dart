import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/utils/formatters.dart';
import '../../../theme/zolya_theme.dart';
import 'zolya_button.dart';

class ZolyaPriceOfferSheet extends StatefulWidget {
  const ZolyaPriceOfferSheet({
    super.key,
    required this.productTitle,
    required this.productPrice,
    required this.onSubmit,
  });

  final String productTitle;
  final int productPrice;
  final ValueChanged<int> onSubmit;

  static Future<void> show(
    BuildContext context, {
    required String productTitle,
    required int productPrice,
    required ValueChanged<int> onSubmit,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: ZolyaPriceOfferSheet(
          productTitle: productTitle,
          productPrice: productPrice,
          onSubmit: onSubmit,
        ),
      ),
    );
  }

  @override
  State<ZolyaPriceOfferSheet> createState() => _ZolyaPriceOfferSheetState();
}

class _ZolyaPriceOfferSheetState extends State<ZolyaPriceOfferSheet> {
  late final TextEditingController _ctrl;
  late int _amount;
  String? _error;

  int get _minOffer => (widget.productPrice / 2).ceil();
  int get _maxOffer => widget.productPrice - 1;

  @override
  void initState() {
    super.initState();
    _amount = ((widget.productPrice * 0.85)).round();
    _ctrl = TextEditingController(text: _amount.toString());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTextChanged(String v) {
    final parsed = int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), ''));
    setState(() {
      if (parsed == null) {
        _error = 'Montant invalide';
        return;
      }
      _amount = parsed;
      _error = _validate(parsed);
    });
  }

  String? _validate(int v) {
    if (v < _minOffer) {
      return 'Minimum : ${Formatters.price(_minOffer)} (50% du prix)';
    }
    if (v >= widget.productPrice) {
      return "L'offre doit être inférieure au prix affiché";
    }
    return null;
  }

  void _onSliderChanged(double v) {
    final rounded = (v / 100).round() * 100;
    setState(() {
      _amount = rounded;
      _ctrl.text = rounded.toString();
      _ctrl.selection =
          TextSelection.collapsed(offset: _ctrl.text.length);
      _error = _validate(rounded);
    });
  }

  void _submit() {
    final err = _validate(_amount);
    if (err != null) {
      setState(() => _error = err);
      return;
    }
    widget.onSubmit(_amount);
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    final discountPct =
        ((1 - _amount / widget.productPrice) * 100).clamp(0, 99).round();

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
                'Faire une offre',
                style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ZolyaSpacing.xs),
              Text(
                widget.productTitle,
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prix demandé',
                    style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                  ),
                  Text(
                    Formatters.price(widget.productPrice),
                    style: ZolyaTypography.subtitle.copyWith(
                      color: scheme.onSurface,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: mutedColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ZolyaSpacing.lg,
                  vertical: ZolyaSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(ZolyaRadius.md),
                  border: Border.all(
                    color: _error != null ? scheme.error : borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'XAF',
                      style: ZolyaTypography.subtitle.copyWith(color: mutedColor),
                    ),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.right,
                        cursorColor: scheme.primary,
                        style: ZolyaTypography.headline.copyWith(
                          color: scheme.onSurface,
                          fontSize: 28,
                        ),
                        decoration: const InputDecoration.collapsed(
                          hintText: '0',
                        ),
                        onChanged: _onTextChanged,
                      ),
                    ),
                  ],
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: ZolyaSpacing.sm),
                Text(
                  _error!,
                  style: ZolyaTypography.bodySmall.copyWith(color: scheme.error),
                ),
              ] else if (discountPct > 0) ...[
                const SizedBox(height: ZolyaSpacing.sm),
                Row(
                  children: [
                    Icon(LucideIcons.tag, size: 14, color: scheme.primary),
                    const SizedBox(width: ZolyaSpacing.xs),
                    Text(
                      '$discountPct % en dessous du prix demandé',
                      style: ZolyaTypography.bodySmall.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: ZolyaSpacing.lg),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: scheme.primary,
                  inactiveTrackColor: borderColor,
                  thumbColor: scheme.primary,
                ),
                child: Slider(
                  value: _amount
                      .clamp(_minOffer, _maxOffer)
                      .toDouble(),
                  min: _minOffer.toDouble(),
                  max: _maxOffer.toDouble(),
                  onChanged: _onSliderChanged,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ZolyaSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Min ${Formatters.price(_minOffer)}',
                      style: ZolyaTypography.label.copyWith(color: mutedColor),
                    ),
                    Text(
                      'Max ${Formatters.price(_maxOffer)}',
                      style: ZolyaTypography.label.copyWith(color: mutedColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Container(
                padding: const EdgeInsets.all(ZolyaSpacing.md),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(LucideIcons.info, size: 16, color: scheme.primary),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Expanded(
                      child: Text(
                        'Le vendeur a 24h pour accepter ou refuser votre offre. '
                        'Vous serez notifié de sa réponse.',
                        style: ZolyaTypography.bodySmall
                            .copyWith(color: mutedColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                label: 'Envoyer l\'offre',
                onPressed: _error == null ? _submit : null,
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
