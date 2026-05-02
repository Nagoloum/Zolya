import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../data/fake/ui_models.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

export '../../../../data/fake/ui_models.dart' show AddressUi;

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.address,
    required this.selected,
    required this.defaultLabel,
    required this.onTap,
  });

  final AddressUi address;
  final bool selected;
  final String defaultLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final iconColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return ZolyaRadioCard(
      title: address.label,
      subtitle: address.fullAddress,
      selected: selected,
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
        ),
        alignment: Alignment.center,
        child: Icon(LucideIcons.mapPin, size: 18, color: iconColor),
      ),
      badge: address.isDefault ? ZolyaBadge(label: defaultLabel) : null,
    );
  }
}
