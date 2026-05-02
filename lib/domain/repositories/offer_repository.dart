import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/offer.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<Offer>>> getMyOffers();
  Future<Either<Failure, Offer>> sendOffer({
    required String productId,
    required int amount,
    String? message,
  });
  Future<Either<Failure, Offer>> respond({
    required String offerId,
    required OfferStatus newStatus,
  });
  Future<Either<Failure, void>> withdraw(String offerId);
}
