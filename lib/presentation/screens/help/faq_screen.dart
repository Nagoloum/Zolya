import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/i18n/app_strings.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class _FaqEntry {
  const _FaqEntry({required this.question, required this.answer});
  final String question;
  final String answer;
}

class _FaqGroup {
  const _FaqGroup({required this.title, required this.entries});
  final String title;
  final List<_FaqEntry> entries;
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String _query = '';

  List<_FaqGroup> _groups(AppStrings l) => [
        _FaqGroup(
          title: l.faqSectionBuying,
          entries: [
            _FaqEntry(question: l.faqQ1Question, answer: l.faqQ1Answer),
            _FaqEntry(question: l.faqQ2Question, answer: l.faqQ2Answer),
            _FaqEntry(question: l.faqQ3Question, answer: l.faqQ3Answer),
            _FaqEntry(question: l.faqQ4Question, answer: l.faqQ4Answer),
          ],
        ),
        _FaqGroup(
          title: l.faqSectionSelling,
          entries: [
            _FaqEntry(question: l.faqQ5Question, answer: l.faqQ5Answer),
            _FaqEntry(question: l.faqQ6Question, answer: l.faqQ6Answer),
            _FaqEntry(question: l.faqQ7Question, answer: l.faqQ7Answer),
          ],
        ),
        _FaqGroup(
          title: l.faqSectionDelivery,
          entries: [
            _FaqEntry(question: l.faqQ8Question, answer: l.faqQ8Answer),
          ],
        ),
        _FaqGroup(
          title: l.faqSectionAccount,
          entries: [
            _FaqEntry(question: l.faqQ9Question, answer: l.faqQ9Answer),
            _FaqEntry(question: l.faqQ10Question, answer: l.faqQ10Answer),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;

    final groups = _groups(l).map((g) {
      final filtered = _query.isEmpty
          ? g.entries
          : g.entries.where((e) {
              final q = _query.toLowerCase();
              return e.question.toLowerCase().contains(q) ||
                  e.answer.toLowerCase().contains(q);
            }).toList();
      return _FaqGroup(title: g.title, entries: filtered);
    }).where((g) => g.entries.isNotEmpty).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.menuFaq, centerTitle: true),
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
              hint: l.faqSearchHint,
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: groups.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(ZolyaSpacing.xxl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.searchX,
                              size: 48, color: mutedColor),
                          const SizedBox(height: ZolyaSpacing.md),
                          Text(
                            l.faqEmptyTitle,
                            style: ZolyaTypography.title
                                .copyWith(color: scheme.onSurface),
                          ),
                          const SizedBox(height: ZolyaSpacing.sm),
                          Text(
                            l.faqEmptyBody,
                            textAlign: TextAlign.center,
                            style: ZolyaTypography.body
                                .copyWith(color: mutedColor),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: ZolyaSpacing.lg),
                    itemCount: groups.length,
                    itemBuilder: (_, i) {
                      final entry = groups[i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: ZolyaSpacing.md),
                            child: Text(
                              entry.title.toUpperCase(),
                              style: ZolyaTypography.label.copyWith(
                                color: mutedColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          for (final item in entry.entries) ...[
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
                label: l.customerServiceTitle,
                leading: const Icon(LucideIcons.headphones, size: 18),
                onPressed: () => context.push(RouteNames.customerService),
                expand: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
