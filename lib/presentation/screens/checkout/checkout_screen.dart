import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/repositories/address_book_repository.dart';
import '../../../domain/repositories/payment_methods_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/checkout/checkout_cubit.dart';
import '../../bloc/checkout/checkout_state.dart';
import '../../widgets/common/momo_logo.dart';
import '../../widgets/zolya/zolya.dart';
import '../address/address_list_screen.dart';
import '../payment_method/payment_method_screen.dart';
import 'widgets/address_block.dart';
import 'widgets/checkout_section.dart';
import 'widgets/order_summary_block.dart';
import 'widgets/payment_chips.dart' as ui_chips;
import 'widgets/promo_code_input.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.productId});
  final String productId;

  int _resolveSubtotal() {
    final product = FakeData.products.firstWhere(
      (p) => p.id == productId,
      orElse: () => FakeData.products.first,
    );
    return product.price;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutCubit>(
      create: (_) => CheckoutCubit(
        addressRepo: sl<AddressBookRepository>(),
        paymentRepo: sl<PaymentMethodsRepository>(),
        subtotal: _resolveSubtotal(),
      )..initDefaults(),
      child: const _CheckoutView(),
    );
  }
}

class _CheckoutView extends StatefulWidget {
  const _CheckoutView();

  @override
  State<_CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<_CheckoutView> {
  final _promoCtrl = TextEditingController();

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  Future<void> _changeAddress(BuildContext context) async {
    final cubit = context.read<CheckoutCubit>();
    final result = await Navigator.of(context).push<AddressUi>(
      MaterialPageRoute(
        builder: (_) =>
            AddressListScreen(initialSelectedId: cubit.state.address?.id),
      ),
    );
    if (result != null) cubit.changeAddress(result);
  }

  Future<void> _changePayment(BuildContext context) async {
    final cubit = context.read<CheckoutCubit>();
    final result = await Navigator.of(context).push<PaymentMethodUi>(
      MaterialPageRoute(
        builder: (_) => PaymentMethodScreen(
            initialSelectedId: cubit.state.method?.id),
      ),
    );
    if (result != null) cubit.changeMethod(result);
  }

  Future<void> _placeOrder(BuildContext context) async {
    final l = context.l10n;
    final ok = await context.read<CheckoutCubit>().placeOrder();
    if (!ok || !context.mounted) return;
    await ZolyaSuccessDialog.show(
      context,
      title: l.checkoutSuccessTitle,
      message: l.checkoutSuccessMessage,
      buttonLabel: l.checkoutTrackOrder,
      onConfirm: () {
        Navigator.of(context).pop();
        context.go(RouteNames.orders);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.checkoutTitle, centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    children: [
                      CheckoutSection(
                        title: l.checkoutDeliveryAddress,
                        actionLabel: l.checkoutChange,
                        onActionTap: () => _changeAddress(context),
                        child: state.address == null
                            ? const _SectionPlaceholder()
                            : AddressBlock(
                                label: state.address!.label,
                                fullAddress: state.address!.fullAddress,
                              ),
                      ),
                      const _SectionDivider(),
                      CheckoutSection(
                        title: l.checkoutPaymentMethod,
                        actionLabel: l.checkoutChange,
                        onActionTap: () => _changePayment(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ui_chips.PaymentChips(
                              selected: _toUiPaymentKind(state.payment),
                              mtnLabel: l.paymentMethodMtn,
                              orangeLabel: l.paymentMethodOrange,
                              onChanged: (kind) => context
                                  .read<CheckoutCubit>()
                                  .changePaymentKind(_toCubitPaymentKind(kind)),
                            ),
                            const SizedBox(height: ZolyaSpacing.md),
                            if (state.method != null)
                              _SelectedMethodRow(
                                method: state.method!,
                                onEditTap: () => _changePayment(context),
                              ),
                          ],
                        ),
                      ),
                      const _SectionDivider(),
                      CheckoutSection(
                        title: l.checkoutOrderSummary,
                        child: OrderSummaryBlock(
                          subtotal: state.subtotal,
                          vat: state.vat,
                          shippingFee: state.shippingFee,
                          total: state.total,
                          subtotalLabel: l.checkoutSubTotal,
                          vatLabel: l.checkoutVat,
                          shippingLabel: l.checkoutShippingFee,
                          totalLabel: l.checkoutTotal,
                        ),
                      ),
                      const SizedBox(height: ZolyaSpacing.xl),
                      PromoCodeInput(
                        controller: _promoCtrl,
                        hint: l.checkoutPromoCodeHint,
                        addLabel: l.checkoutPromoAdd,
                        onAdd: () => context
                            .read<CheckoutCubit>()
                            .setPromoCode(_promoCtrl.text.trim()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: ZolyaButton(
                    label: l.checkoutPlaceOrder,
                    onPressed: state.isPlacing || state.address == null
                        ? null
                        : () => _placeOrder(context),
                    loading: state.isPlacing,
                    expand: true,
                    size: ZolyaButtonSize.lg,
                    leading: const Icon(LucideIcons.shoppingBag, size: 18),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ui_chips.CheckoutPaymentKind _toUiPaymentKind(CheckoutPaymentKind k) =>
      k == CheckoutPaymentKind.mtn
          ? ui_chips.CheckoutPaymentKind.mtn
          : ui_chips.CheckoutPaymentKind.orange;

  CheckoutPaymentKind _toCubitPaymentKind(ui_chips.CheckoutPaymentKind k) =>
      k == ui_chips.CheckoutPaymentKind.mtn
          ? CheckoutPaymentKind.mtn
          : CheckoutPaymentKind.orange;
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Divider(
          color: Theme.of(context).colorScheme.outline,
          height: 1,
          thickness: 0.5),
    );
  }
}

class _SectionPlaceholder extends StatelessWidget {
  const _SectionPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: const Center(child: ZolyaSpinner(size: ZolyaSpinnerSize.sm)),
    );
  }
}

class _SelectedMethodRow extends StatelessWidget {
  const _SelectedMethodRow({required this.method, required this.onEditTap});
  final PaymentMethodUi method;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.md + 2,
        vertical: ZolyaSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: scheme.outline),
            ),
            alignment: Alignment.center,
            child: MomoLogo(provider: method.provider, width: 40, height: 24),
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Text(
              method.maskedNumber,
              style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
            ),
          ),
          InkWell(
            onTap: onEditTap,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(ZolyaSpacing.xs + 2),
              child: Icon(LucideIcons.pencil, size: 16, color: mutedColor),
            ),
          ),
        ],
      ),
    );
  }
}
