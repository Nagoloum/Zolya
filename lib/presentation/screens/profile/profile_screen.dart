import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/zolya/zolya.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        final l = context.l10n;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: ZolyaTopBar(
            title: l.profileTitle,
            showBack: false,
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: ZolyaSpacing.lg,
              vertical: ZolyaSpacing.lg,
            ),
            children: [
              _ProfileHeader(
                name: user?.fullName ?? '—',
                phone: user?.phone ?? '—',
              ).animate().fadeIn(duration: 250.ms),
              const SizedBox(height: ZolyaSpacing.xl),
              _WalletSummary(
                balance: user?.walletBalance ?? 0,
                label: l.walletShortcut,
              ).animate().fadeIn(delay: 80.ms, duration: 250.ms),
              const SizedBox(height: ZolyaSpacing.xl),
              _SectionHeader(title: l.sectionMySales),
              _MenuItem(
                icon: LucideIcons.shoppingBag,
                label: l.menuMyArticles,
                onTap: () => context.push(RouteNames.myListings),
              ),
              _MenuItem(
                icon: LucideIcons.tag,
                label: l.menuMyDiscounts,
                onTap: () => context.push(RouteNames.discounts),
              ),
              _MenuItem(
                icon: LucideIcons.receiptText,
                label: l.menuSalesHistory,
                onTap: () => context.go(RouteNames.orders),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              _SectionHeader(title: l.sectionMyPurchases),
              _MenuItem(
                icon: LucideIcons.heart,
                label: l.menuFavorites,
                onTap: () => context.push(RouteNames.favorites),
              ),
              _MenuItem(
                icon: LucideIcons.history,
                label: l.menuPurchaseHistory,
                onTap: () => context.go(RouteNames.orders),
              ),
              _MenuItem(
                icon: LucideIcons.tags,
                label: l.menuMyOffers,
                badge: '2',
                onTap: () => context.push(RouteNames.myOffers),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              _SectionHeader(title: l.sectionAccount),
              _MenuItem(
                icon: LucideIcons.userRound,
                label: l.menuPersonalInfo,
                onTap: () => context.push(RouteNames.editProfile),
              ),
              _MenuItem(
                icon: LucideIcons.mapPin,
                label: l.menuMyAddresses,
                onTap: () => context.push(RouteNames.addressList),
              ),
              _MenuItem(
                icon: LucideIcons.creditCard,
                label: l.menuPaymentMethods,
                onTap: () => context.push(RouteNames.paymentMethods),
              ),
              _MenuItem(
                icon: LucideIcons.wallet,
                label: l.menuWallet,
                onTap: () => context.push(RouteNames.wallet),
              ),
              _MenuItem(
                icon: LucideIcons.bell,
                label: l.menuNotifications,
                onTap: () => context.push(RouteNames.notifications),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              _SectionHeader(title: l.sectionHelp),
              _MenuItem(
                icon: LucideIcons.lifeBuoy,
                label: l.menuFaq,
                onTap: () => context.push(RouteNames.faq),
              ),
              _MenuItem(
                icon: LucideIcons.headphones,
                label: l.menuContactUs,
                onTap: () => context.push(RouteNames.contactSupport),
              ),
              _MenuItem(
                icon: LucideIcons.star,
                label: l.menuRateApp,
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.userPlus,
                label: l.menuInviteFriend,
                trailingLabel: l.menuInviteEarn,
                onTap: () => context.push(RouteNames.inviteFriends),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              _SectionHeader(title: l.sectionPreferences),
              _MenuItem(
                icon: LucideIcons.settings2,
                label: l.menuSettings,
                onTap: () => context.push(RouteNames.settings),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              _SectionHeader(title: l.sectionLegal),
              _MenuItem(
                icon: LucideIcons.fileText,
                label: l.menuTerms,
                onTap: () => context.push(RouteNames.legalTerms),
              ),
              _MenuItem(
                icon: LucideIcons.shield,
                label: l.menuPrivacy,
                onTap: () => context.push(RouteNames.legalPrivacy),
              ),
              _MenuItem(
                icon: LucideIcons.cookie,
                label: l.menuCookies,
                onTap: () => context.push(RouteNames.legalCookies),
              ),
              _MenuItem(
                icon: LucideIcons.info,
                label: l.menuAboutZolya,
                onTap: () => context.push(RouteNames.aboutZolya),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              _MenuItem(
                icon: LucideIcons.logOut,
                label: l.menuLogout,
                color: Theme.of(context).colorScheme.error,
                onTap: () =>
                    context.read<AuthBloc>().add(AuthLogoutRequested()),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Center(
                child: Text(
                  'Zolya v1.0.0',
                  style: ZolyaTypography.label.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? ZolyaColors.texte3
                        : ZolyaColors.texte3Dark,
                  ),
                ),
              ),
              const SizedBox(height: ZolyaSpacing.xxl),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name, required this.phone});
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final chevronColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(RouteNames.myProfile),
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: Container(
          padding: const EdgeInsets.all(ZolyaSpacing.md),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              ZolyaAvatar(name: name, size: ZolyaAvatarSize.lg),
              const SizedBox(width: ZolyaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: ZolyaTypography.title
                          .copyWith(color: scheme.onSurface),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: ZolyaSpacing.xs / 2),
                    Text(
                      phone,
                      style: ZolyaTypography.bodySmall
                          .copyWith(color: mutedColor),
                    ),
                    const SizedBox(height: ZolyaSpacing.sm),
                    Row(
                      children: [
                        Icon(LucideIcons.star,
                            size: 12, color: scheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          '4.8 (52 avis)',
                          style: ZolyaTypography.label
                              .copyWith(color: mutedColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: ZolyaSpacing.sm),
              Icon(LucideIcons.chevronRight, size: 18, color: chevronColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletSummary extends StatelessWidget {
  const _WalletSummary({required this.balance, required this.label});
  final int balance;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ZolyaGradientCard(
      onTap: () => context.push(RouteNames.wallet),
      child: Row(
        children: [
          const Icon(LucideIcons.wallet, color: ZolyaColors.noir, size: 22),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: ZolyaTypography.bodySmall.copyWith(
                    color: ZolyaColors.noir.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  Formatters.price(balance),
                  style: ZolyaTypography.title.copyWith(
                    color: ZolyaColors.noir,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight,
              color: ZolyaColors.noir, size: 18),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        ZolyaSpacing.xs,
        ZolyaSpacing.sm,
        ZolyaSpacing.xs,
        ZolyaSpacing.xs,
      ),
      child: Text(
        title.toUpperCase(),
        style: ZolyaTypography.label.copyWith(
          color: mutedColor,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.badge,
    this.trailingLabel,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final String? badge;
  final String? trailingLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final chevronColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final c = color ?? scheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ZolyaSpacing.xs,
            vertical: ZolyaSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, color: c, size: 20),
              const SizedBox(width: ZolyaSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: ZolyaTypography.body.copyWith(color: c),
                ),
              ),
              if (badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ZolyaSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(ZolyaRadius.full),
                  ),
                  child: Text(
                    badge!,
                    style: ZolyaTypography.label.copyWith(
                      color: scheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: ZolyaSpacing.sm),
              ],
              if (trailingLabel != null) ...[
                Text(
                  trailingLabel!,
                  style: ZolyaTypography.bodySmall.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: ZolyaSpacing.sm),
              ],
              if (color == null)
                Icon(LucideIcons.chevronRight, color: chevronColor, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
