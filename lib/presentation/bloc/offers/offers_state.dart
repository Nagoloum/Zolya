import 'package:equatable/equatable.dart';

import '../../../domain/entities/offer.dart';

class OffersState extends Equatable {
  const OffersState({
    this.offers = const <Offer>[],
    this.loading = false,
    this.error,
  });

  final List<Offer> offers;
  final bool loading;
  final String? error;

  List<Offer> get sent =>
      offers.where((o) => o.direction == OfferDirection.sent).toList();
  List<Offer> get received =>
      offers.where((o) => o.direction == OfferDirection.received).toList();

  int get pendingReceivedCount =>
      received.where((o) => o.isPending && !o.isExpired).length;

  OffersState copyWith({
    List<Offer>? offers,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return OffersState(
      offers: offers ?? this.offers,
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [offers, loading, error];
}
