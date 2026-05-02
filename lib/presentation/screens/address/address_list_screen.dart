import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../domain/repositories/address_book_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/address_book/address_book_cubit.dart';
import '../../bloc/address_book/address_book_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'new_address_bottom_sheet.dart';
import 'widgets/address_tile.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key, this.initialSelectedId});

  final String? initialSelectedId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressBookCubit>(
      create: (_) => AddressBookCubit(repo: sl<AddressBookRepository>())
        ..load(initialSelectedId: initialSelectedId),
      child: const _AddressListView(),
    );
  }
}

class _AddressListView extends StatelessWidget {
  const _AddressListView();

  Future<void> _addNew(BuildContext context) async {
    final result = await NewAddressBottomSheet.show(context);
    if (result == null || !context.mounted) return;
    await context.read<AddressBookCubit>().addAddress(
          label: result.nickname,
          fullAddress: result.fullAddress,
          isDefault: result.isDefault,
        );
    if (!context.mounted) return;
    await showAddressAddedDialog(context);
  }

  void _apply(BuildContext context) {
    final selected = context.read<AddressBookCubit>().state.selected;
    if (selected != null) Navigator.of(context).pop(selected);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.addressTitle, centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AddressBookCubit, AddressBookState>(
            builder: (context, state) {
              if (state.loading && state.addresses.isEmpty) {
                return const Center(child: ZolyaSpinner());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l.addressSaved, style: ZolyaTypography.subtitle),
                  const SizedBox(height: ZolyaSpacing.md),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.addresses.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        if (index < state.addresses.length) {
                          final a = state.addresses[index];
                          return AddressTile(
                            address: a,
                            selected: a.id == state.selectedId,
                            defaultLabel: l.addressDefault,
                            onTap: () => context
                                .read<AddressBookCubit>()
                                .select(a.id),
                          );
                        }
                        return _AddNewButton(
                          label: l.addressAddNew,
                          onTap: () => _addNew(context),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.md),
                  ZolyaButton(
                    label: l.addressApply,
                    onPressed: state.selected != null
                        ? () => _apply(context)
                        : null,
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
