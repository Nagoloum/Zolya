import 'package:equatable/equatable.dart';

import '../../../data/fake/ui_models.dart';

class DiscountsState extends Equatable {
  const DiscountsState({
    this.discounts = const <DiscountUi>[],
    this.loading = false,
    this.error,
  });

  final List<DiscountUi> discounts;
  final bool loading;
  final String? error;

  DiscountsState copyWith({
    List<DiscountUi>? discounts,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return DiscountsState(
      discounts: discounts ?? this.discounts,
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [discounts, loading, error];
}
