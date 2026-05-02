import 'package:flutter/material.dart';

import '../../../../core/i18n/locale_provider.dart';
import '../../../widgets/zolya/zolya.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
    required this.current,
    required this.onChanged,
    required this.englishLabel,
    required this.frenchLabel,
  });

  final AppLocale current;
  final ValueChanged<AppLocale> onChanged;
  final String englishLabel;
  final String frenchLabel;

  @override
  Widget build(BuildContext context) {
    return ZolyaSegmentedControl<AppLocale>(
      value: current,
      segments: [
        ZolyaSegment(value: AppLocale.en, label: englishLabel),
        ZolyaSegment(value: AppLocale.fr, label: frenchLabel),
      ],
      onChanged: onChanged,
    );
  }
}
