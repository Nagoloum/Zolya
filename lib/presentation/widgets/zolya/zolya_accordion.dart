import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaAccordion extends StatefulWidget {
  const ZolyaAccordion({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.initiallyExpanded = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  State<ZolyaAccordion> createState() => _ZolyaAccordionState();
}

class _ZolyaAccordionState extends State<ZolyaAccordion>
    with SingleTickerProviderStateMixin {
  late bool _expanded = widget.initiallyExpanded;
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    value: _expanded ? 1 : 0,
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outline, width: 0.8),
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            child: Padding(
              padding: const EdgeInsets.all(ZolyaSpacing.md),
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: ZolyaSpacing.md),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: ZolyaTypography.subtitle
                              .copyWith(color: scheme.onSurface),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: ZolyaSpacing.xs / 2),
                          Text(
                            widget.subtitle!,
                            style: ZolyaTypography.bodySmall
                                .copyWith(color: mutedColor),
                          ),
                        ],
                      ],
                    ),
                  ),
                  RotationTransition(
                    turns:
                        Tween<double>(begin: 0, end: 0.5).animate(_ctrl),
                    child: Icon(LucideIcons.chevronDown,
                        size: 18, color: mutedColor),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _ctrl,
                curve: Curves.easeOut,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  ZolyaSpacing.md,
                  0,
                  ZolyaSpacing.md,
                  ZolyaSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
