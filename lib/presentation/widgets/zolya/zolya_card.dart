import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaCard extends StatelessWidget {
  const ZolyaCard({
    super.key,
    this.child,
    this.title,
    this.description,
    this.footer,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(ZolyaSpacing.lg),
    this.backgroundColor,
  });

  final Widget? child;
  final Widget? title;
  final Widget? description;
  final Widget? footer;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final card = ShadCard(
      title: title,
      description: description,
      footer: footer,
      leading: leading,
      trailing: trailing,
      padding: padding,
      backgroundColor: backgroundColor,
      child: child,
    );

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.md),
      child: card,
    );
  }
}
