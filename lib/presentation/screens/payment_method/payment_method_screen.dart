import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../domain/repositories/payment_methods_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/payment_methods/payment_methods_cubit.dart';
import '../../bloc/payment_methods/payment_methods_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'add_payment_method_screen.dart';
import 'widgets/payment_tile.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key, this.initialSelectedId});
  final String? initialSelectedId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentMethodsCubit>(
      create: (_) => PaymentMethodsCubit(repo: sl<PaymentMethodsRepository>())
        ..load(initialSelectedId: initialSelectedId),
      child: const _PaymentMethodView(),
    );
  }
}

class _PaymentMethodView extends StatelessWidget {
  const _PaymentMethodView();

  String _providerLabel(BuildContext context, MomoProvider p) {
    final l = context.l10n;
    return p == MomoProvider.mtn ? l.paymentMethodMtn : l.paymentMethodOrange;
  }

  Future<void> _addNew(BuildContext context) async {
    final result = await Navigator.of(context).push<AddPaymentResult>(
      MaterialPageRoute(builder: (_) => const AddPaymentMethodScreen()),
    );
    if (result == null || !context.mounted) return;
    await context.read<PaymentMethodsCubit>().addMethod(
          provider: result.provider,
          phone: result.phone,
        );
  }

  void _apply(BuildContext context) {
    final cubit = context.read<PaymentMethodsCubit>();
    final selected = cubit.state.selected;
    if (selected != null) {
      Navigator.of(context).pop(selected);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.paymentTitle, centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
            builder: (context, state) {
              if (state.loading && state.methods.isEmpty) {
                return const Center(child: ZolyaSpinner());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l.paymentSaved, style: ZolyaTypography.subtitle),
                  const SizedBox(height: ZolyaSpacing.md),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.methods.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        if (index < state.methods.length) {
                          final m = state.methods[index];
                          return PaymentTile(
                            method: m,
                            selected: m.id == state.selectedId,
                            defaultLabel: l.addressDefault,
                            providerLabel:
                                _providerLabel(context, m.provider),
                            onTap: () => context
                                .read<PaymentMethodsCubit>()
                                .select(m.id),
                          );
                        }
                        return _AddNewButton(
                          label: l.paymentAddNew,
                          onTap: () => _addNew(context),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.md),
                  ZolyaButton(
                    label: l.addressApply,
                    onPressed: () => _apply(context),
                    expand: true,
                    size: ZolyaButtonSize.lg,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AddNewButton extends StatelessWidget {
  const _AddNewButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.md),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.lg + 2),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          border: Border.all(color: scheme.outline),
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.plus, size: 18, color: scheme.primary),
            const SizedBox(width: ZolyaSpacing.sm),
            Text(
              label,
              style: ZolyaTypography.body.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
