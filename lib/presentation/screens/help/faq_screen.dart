import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../data/fake/fake_data.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    final sections = FakeData.faq.map((s) {
      final filtered = _query.isEmpty
          ? s.items
          : s.items.where((i) {
              final q = _query.toLowerCase();
              return i.question.toLowerCase().contains(q) ||
                  i.answer.toLowerCase().contains(q);
            }).toList();
      return MapEntry(s.title, filtered);
    }).where((e) => e.value.isNotEmpty).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'Frequently asked questions', centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              ZolyaSpacing.lg,
              ZolyaSpacing.sm,
              ZolyaSpacing.lg,
              ZolyaSpacing.lg,
            ),
            child: ZolyaSearchField(
              hint: 'Search a question…',
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: sections.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(ZolyaSpacing.xxl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.searchX, size: 48, color: mutedColor),
                          const SizedBox(height: ZolyaSpacing.md),
                          Text(
                            'No result',
                            style: ZolyaTypography.title
                                .copyWith(color: scheme.onSurface),
                          ),
                          const SizedBox(height: ZolyaSpacing.sm),
                          Text(
                            'Try another keyword or contact support.',
                            textAlign: TextAlign.center,
                            style: ZolyaTypography.body.copyWith(color: mutedColor),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: ZolyaSpacing.lg),
                    itemCount: sections.length,
                    itemBuilder: (_, i) {
                      final entry = sections[i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: ZolyaSpacing.md),
                            child: Text(
                              entry.key.toUpperCase(),
                              style: ZolyaTypography.label.copyWith(
                                color: mutedColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          for (final item in entry.value) ...[
                            ZolyaAccordion(
                              title: item.question,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    item.answer,
                                    style: ZolyaTypography.body.copyWith(
                                      color: mutedColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: ZolyaSpacing.sm),
                          ],
                          const SizedBox(height: ZolyaSpacing.md),
                        ],
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(ZolyaSpacing.lg),
              child: ZolyaButton(
                variant: ZolyaButtonVariant.outline,
                label: 'Contact support',
                leading: const Icon(LucideIcons.mail, size: 18),
                onPressed: () {},
                expand: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
