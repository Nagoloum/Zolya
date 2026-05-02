import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/notification_prefs/notification_prefs_cubit.dart';
import '../../widgets/zolya/zolya.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationPrefsCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.notifPrefsTitle, centerTitle: true),
      body: BlocBuilder<NotificationPrefsCubit, NotificationPrefs>(
        builder: (context, prefs) {
          final cubit = context.read<NotificationPrefsCubit>();
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: ZolyaSpacing.lg,
              vertical: ZolyaSpacing.sm,
            ),
            children: [
              _PrefRow(
                label: l.notifPrefGeneral,
                value: prefs.general,
                onChanged: () => cubit.toggle('general'),
              ),
              _PrefRow(
                label: l.notifPrefSound,
                value: prefs.sound,
                onChanged: () => cubit.toggle('sound'),
              ),
              _PrefRow(
                label: l.notifPrefVibrate,
                value: prefs.vibrate,
                onChanged: () => cubit.toggle('vibrate'),
              ),
              _PrefRow(
                label: l.notifPrefSpecialOffers,
                value: prefs.specialOffers,
                onChanged: () => cubit.toggle('specialOffers'),
                showSeparator: true,
              ),
              _PrefRow(
                label: l.notifPrefPromoDiscounts,
                value: prefs.promoDiscounts,
                onChanged: () => cubit.toggle('promoDiscounts'),
              ),
              _PrefRow(
                label: l.notifPrefPayments,
                value: prefs.payments,
                onChanged: () => cubit.toggle('payments'),
              ),
              _PrefRow(
                label: l.notifPrefCashback,
                value: prefs.cashback,
                onChanged: () => cubit.toggle('cashback'),
              ),
              _PrefRow(
                label: l.notifPrefAppUpdates,
                value: prefs.appUpdates,
                onChanged: () => cubit.toggle('appUpdates'),
              ),
              _PrefRow(
                label: l.notifPrefNewService,
                value: prefs.newService,
                onChanged: () => cubit.toggle('newService'),
              ),
              _PrefRow(
                label: l.notifPrefNewTips,
                value: prefs.newTips,
                onChanged: () => cubit.toggle('newTips'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  const _PrefRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.showSeparator = false,
  });

  final String label;
  final bool value;
  final VoidCallback onChanged;
  final bool showSeparator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Column(
      children: [
        if (showSeparator) ...[
          const SizedBox(height: ZolyaSpacing.sm),
          Container(height: 1.5, color: scheme.primary),
          const SizedBox(height: ZolyaSpacing.sm),
        ],
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: ZolyaSpacing.md + 2),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style:
                      ZolyaTypography.body.copyWith(color: scheme.onSurface),
                ),
              ),
              ZolyaSwitch(
                value: value,
                onChanged: (_) => onChanged(),
              ),
            ],
          ),
        ),
        if (!showSeparator)
          Container(height: 1, color: borderColor.withValues(alpha: 0.4)),
      ],
    );
  }
}
