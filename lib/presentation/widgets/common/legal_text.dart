import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zolya/theme/zolya_theme.dart';

class LegalLink {
  final String label;
  final VoidCallback onTap;

  const LegalLink({required this.label, required this.onTap});
}

class LegalText extends StatelessWidget {
  final String prefix;
  final List<LegalLink> links;
  final String betweenLinks;
  final String? suffix;
  final LegalLink? trailingLink;

  const LegalText({
    super.key,
    required this.prefix,
    required this.links,
    this.betweenLinks = ', ',
    this.suffix,
    this.trailingLink,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final baseStyle = ZolyaTypography.bodySmall
        .copyWith(color: cs.onSurface.withValues(alpha: 0.65));
    final linkStyle = baseStyle.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    );

    final spans = <InlineSpan>[TextSpan(text: prefix)];

    for (var i = 0; i < links.length; i++) {
      spans.add(_linkSpan(links[i], linkStyle));
      if (i < links.length - 1) {
        spans.add(TextSpan(text: betweenLinks));
      }
    }

    if (suffix != null) spans.add(TextSpan(text: suffix));
    if (trailingLink != null) spans.add(_linkSpan(trailingLink!, linkStyle));
    spans.add(const TextSpan(text: '.'));

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
    );
  }

  TextSpan _linkSpan(LegalLink link, TextStyle style) {
    return TextSpan(
      text: link.label,
      style: style,
      recognizer: TapGestureRecognizer()..onTap = link.onTap,
    );
  }
}
