import 'package:flutter/material.dart';

import '../../../../core/i18n/locale_provider.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class LegalSection {
  const LegalSection({required this.title, required this.paragraphs});
  final String title;
  final List<String> paragraphs;
}

class LegalScaffold extends StatelessWidget {
  const LegalScaffold({
    super.key,
    required this.title,
    required this.lastUpdated,
    required this.intro,
    required this.sections,
  });

  final String title;
  final String lastUpdated;
  final String intro;
  final List<LegalSection> sections;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: title, centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: ZolyaSpacing.lg,
            vertical: ZolyaSpacing.lg,
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ZolyaBadge(
                label: '${l.legalLastUpdated} : $lastUpdated',
              ),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            Text(
              intro,
              style: ZolyaTypography.body
                  .copyWith(color: mutedColor, height: 1.6),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            for (final section in sections) ...[
              Text(
                section.title,
                style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              for (final p in section.paragraphs) ...[
                Text(
                  p,
                  style: ZolyaTypography.body
                      .copyWith(color: mutedColor, height: 1.6),
                ),
                const SizedBox(height: ZolyaSpacing.sm),
              ],
              const SizedBox(height: ZolyaSpacing.md),
            ],
            const SizedBox(height: ZolyaSpacing.lg),
          ],
        ),
      ),
    );
  }
}
