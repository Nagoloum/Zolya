import 'package:equatable/equatable.dart';

import '../../../data/fake/ui_models.dart';

class PaymentMethodsState extends Equatable {
  const PaymentMethodsState({
    this.methods = const <PaymentMethodUi>[],
    this.selectedId,
    this.loading = false,
    this.error,
  });

  final List<PaymentMethodUi> methods;
  final String? selectedId;
  final bool loading;
  final String? error;

  PaymentMethodUi? get selected {
    if (selectedId == null) return null;
    for (final m in methods) {
      if (m.id == selectedId) return m;
    }
    return null;
  }

  PaymentMethodsState copyWith({
    List<PaymentMethodUi>? methods,
    String? selectedId,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return PaymentMethodsState(
      methods: methods ?? this.methods,
      selectedId: selectedId ?? this.selectedId,
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [methods, selectedId, loading, error];
}
