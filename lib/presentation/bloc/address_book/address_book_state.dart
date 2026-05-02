import 'package:equatable/equatable.dart';

import '../../../data/fake/ui_models.dart';

class AddressBookState extends Equatable {
  const AddressBookState({
    this.addresses = const <AddressUi>[],
    this.selectedId,
    this.loading = false,
    this.error,
  });

  final List<AddressUi> addresses;
  final String? selectedId;
  final bool loading;
  final String? error;

  AddressUi? get selected {
    if (selectedId == null) return null;
    for (final a in addresses) {
      if (a.id == selectedId) return a;
    }
    return null;
  }

  AddressUi? get defaultAddress {
    for (final a in addresses) {
      if (a.isDefault) return a;
    }
    return addresses.isNotEmpty ? addresses.first : null;
  }

  AddressBookState copyWith({
    List<AddressUi>? addresses,
    String? selectedId,
    bool clearSelection = false,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return AddressBookState(
      addresses: addresses ?? this.addresses,
      selectedId:
          clearSelection ? null : (selectedId ?? this.selectedId),
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [addresses, selectedId, loading, error];
}
