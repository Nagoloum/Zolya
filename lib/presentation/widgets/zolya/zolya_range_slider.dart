import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaRangeSlider extends StatelessWidget {
  const ZolyaRangeSlider({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: ZolyaColors.or,
        inactiveTrackColor: Theme.of(context).colorScheme.outline,
        thumbColor: ZolyaColors.or,
        overlayColor: ZolyaColors.or.withValues(alpha: 0.15),
        rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
        trackHeight: 4,
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 10,
          elevation: 2,
        ),
      ),
      child: RangeSlider(
        values: values,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}

class ZolyaSlider extends StatelessWidget {
  const ZolyaSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: ZolyaColors.or,
        inactiveTrackColor: Theme.of(context).colorScheme.outline,
        thumbColor: ZolyaColors.or,
        overlayColor: ZolyaColors.or.withValues(alpha: 0.15),
        trackHeight: 4,
        thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 10, elevation: 2),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
