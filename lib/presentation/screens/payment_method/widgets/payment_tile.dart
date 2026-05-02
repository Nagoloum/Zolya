import 'package:flutter/material.dart';

import '../../../../data/fake/ui_models.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/common/momo_logo.dart';
import '../../../widgets/zolya/zolya.dart';

export '../../../../data/fake/ui_models.dart' show MomoProvider, PaymentMethodUi;

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.method,
    required this.selected,
    required this.defaultLabel,
    required this.providerLabel,
    required this.onTap,
  });

  final PaymentMethodUi method;
  final bool selected;
  final String defaultLabel;
  final String providerLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZolyaRadioCard(
      title: providerLabel,
      subtitle: method.maskedNumber,
      selected: selected,
      onTap: onTap,
      leading: _ProviderBadge(provider: method.provider),
      badge: method.isDefault ? ZolyaBadge(label: defaultLabel) : null,
    );
  }
}

class _ProviderBadge extends StatelessWidget {
  const _ProviderBadge({required this.provider});
  final MomoProvider provider;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 52,
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.xs, vertical: 3),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border.all(color: scheme.outline),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: MomoLogo(provider: provider, width: 44, height: 26),
    );
  }
}
