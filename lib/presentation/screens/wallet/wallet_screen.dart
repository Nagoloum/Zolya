import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/utils/formatters.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/zolya/zolya.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'Wallet', centerTitle: true),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final balance =
              state is AuthAuthenticated ? state.user.walletBalance : 0;
          return ListView(
            padding: const EdgeInsets.all(ZolyaSpacing.lg),
            children: [
              _BalanceCard(balance: balance)
                  .animate()
                  .fadeIn(duration: 250.ms),
              const SizedBox(height: ZolyaSpacing.xl),
              Text(
                'RECENT TRANSACTIONS',
                style: ZolyaTypography.label.copyWith(
                  color: mutedColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: ZolyaSpacing.md),
              const _TransactionTile(
                icon: LucideIcons.arrowDownLeft,
                title: 'Sale "Nike Air Force 1"',
                subtitle: '2 days ago',
                amount: '+ 24 225 FCFA',
                positive: true,
              ),
              const _TransactionTile(
                icon: LucideIcons.arrowUpRight,
                title: 'MTN MoMo withdrawal',
                subtitle: '1 week ago',
                amount: '- 15 000 FCFA',
                positive: false,
              ),
              const _TransactionTile(
                icon: LucideIcons.arrowDownLeft,
                title: 'Sale "Pleated Midi Skirt"',
                subtitle: '2 weeks ago',
                amount: '+ 5 780 FCFA',
                positive: true,
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Container(
                padding: const EdgeInsets.all(ZolyaSpacing.md),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(ZolyaRadius.md),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(LucideIcons.shieldCheck,
                        size: 18, color: scheme.primary),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Expanded(
                      child: Text(
                        'Your funds are secured in escrow by Zolya. '
                        'Withdrawals are processed within 24 business hours '
                        'to your Mobile Money account.',
                        style: ZolyaTypography.bodySmall
                            .copyWith(color: mutedColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.balance});
  final int balance;

  @override
  Widget build(BuildContext context) {
    return ZolyaGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.wallet,
                  color: ZolyaColors.noir, size: 18),
              const SizedBox(width: ZolyaSpacing.sm),
              Text(
                'Available balance',
                style: ZolyaTypography.bodySmall.copyWith(
                  color: ZolyaColors.noir.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: ZolyaSpacing.md),
          Text(
            Formatters.price(balance),
            style: ZolyaTypography.displayMedium.copyWith(
              color: ZolyaColors.noir,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: ZolyaSpacing.lg),
          Row(
            children: [
              Expanded(
                child: ZolyaButton(
                  variant: ZolyaButtonVariant.secondary,
                  label: 'Withdraw',
                  leading: const Icon(LucideIcons.arrowUpRight, size: 16),
                  onPressed: () {},
                  expand: true,
                ),
              ),
              const SizedBox(width: ZolyaSpacing.sm),
              Expanded(
                child: ZolyaButton(
                  variant: ZolyaButtonVariant.secondary,
                  label: 'Top up',
                  leading: const Icon(LucideIcons.plus, size: 16),
                  onPressed: () {},
                  expand: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.positive,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final amountColor =
        positive ? ZolyaColors.succes : scheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: ZolyaSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(ZolyaRadius.sm),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: scheme.onSurface),
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style:
                      ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: ZolyaTypography.subtitle.copyWith(color: amountColor),
          ),
        ],
      ),
    );
  }
}
