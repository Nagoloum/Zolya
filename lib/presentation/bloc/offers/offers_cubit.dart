import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/offer.dart';
import '../../../domain/repositories/offer_repository.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit({required this.repo}) : super(const OffersState());

  final OfferRepository repo;

  Future<void> load() async {
    emit(state.copyWith(loading: true, clearError: true));
    final result = await repo.getMyOffers();
    result.fold(
      (f) => emit(state.copyWith(loading: false, error: f.message)),
      (offers) => emit(state.copyWith(loading: false, offers: offers)),
    );
  }

  Future<Offer?> sendOffer({
    required String productId,
    required int amount,
    String? message,
  }) async {
    final result = await repo.sendOffer(
      productId: productId,
      amount: amount,
      message: message,
    );
    return result.fold(
      (f) {
        emit(state.copyWith(error: f.message));
        return null;
      },
      (offer) {
        emit(state.copyWith(offers: [offer, ...state.offers]));
        return offer;
      },
    );
  }

  Future<void> respond({
    required String offerId,
    required OfferStatus newStatus,
  }) async {
    final result = await repo.respond(offerId: offerId, newStatus: newStatus);
    result.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (updated) {
        final next = state.offers
            .map((o) => o.id == updated.id ? updated : o)
            .toList();
        emit(state.copyWith(offers: next));
      },
    );
  }

  Future<void> withdraw(String offerId) async {
    final result = await repo.withdraw(offerId);
    result.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (_) {
        final next = state.offers
            .map((o) => o.id == offerId
                ? o.copyWith(status: OfferStatus.withdrawn)
                : o)
            .toList();
        emit(state.copyWith(offers: next));
      },
    );
  }
}
