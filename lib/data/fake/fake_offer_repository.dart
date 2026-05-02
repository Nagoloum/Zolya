import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/offer.dart';
import '../../domain/repositories/offer_repository.dart';
import 'fake_data.dart';

class FakeOfferRepository implements OfferRepository {
  final List<Offer> _offers = [];
  bool _seeded = false;

  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  void _seed() {
    if (_seeded) return;
    _seeded = true;
    final now = DateTime.now();
    final user = FakeData.currentUser;
    // Two sent offers
    final p1 = FakeData.products[0];
    final p2 = FakeData.products[6];
    final p3 = FakeData.products[2];
    final seller1 = FakeData.sellerFor(p1.sellerId);
    final seller2 = FakeData.sellerFor(p2.sellerId);
    final seller3 = FakeData.sellerFor(p3.sellerId);
    _offers.addAll([
      Offer(
        id: 'of-1',
        productId: p1.id,
        productTitle: p1.title,
        productImageUrl: p1.mainImageUrl,
        productPrice: p1.price,
        offerAmount: 6500,
        buyerId: user.id,
        buyerName: user.fullName,
        buyerAvatarUrl: user.avatarUrl,
        sellerId: seller1.id,
        sellerName: seller1.fullName,
        sellerAvatarUrl: seller1.avatarUrl,
        status: OfferStatus.pending,
        direction: OfferDirection.sent,
        createdAt: now.subtract(const Duration(hours: 4)),
        expiresAt: now.add(const Duration(hours: 20)),
      ),
      Offer(
        id: 'of-2',
        productId: p2.id,
        productTitle: p2.title,
        productImageUrl: p2.mainImageUrl,
        productPrice: p2.price,
        offerAmount: 22000,
        buyerId: user.id,
        buyerName: user.fullName,
        buyerAvatarUrl: user.avatarUrl,
        sellerId: seller2.id,
        sellerName: seller2.fullName,
        sellerAvatarUrl: seller2.avatarUrl,
        status: OfferStatus.accepted,
        direction: OfferDirection.sent,
        createdAt: now.subtract(const Duration(days: 2)),
        expiresAt: now.subtract(const Duration(days: 1)),
        respondedAt: now.subtract(const Duration(days: 1, hours: 12)),
      ),
      // One received offer (someone offering on user's product — fictional)
      Offer(
        id: 'of-3',
        productId: p3.id,
        productTitle: p3.title,
        productImageUrl: p3.mainImageUrl,
        productPrice: p3.price,
        offerAmount: 5500,
        buyerId: 'u-100',
        buyerName: 'Aïssa M.',
        buyerAvatarUrl: 'https://i.pravatar.cc/150?img=44',
        sellerId: user.id,
        sellerName: user.fullName,
        sellerAvatarUrl: user.avatarUrl,
        message: 'Bonjour, êtes-vous OK pour ce prix ? Merci !',
        status: OfferStatus.pending,
        direction: OfferDirection.received,
        createdAt: now.subtract(const Duration(hours: 1)),
        expiresAt: now.add(const Duration(hours: 23)),
      ),
      Offer(
        id: 'of-4',
        productId: seller3.id,
        productTitle: 'Floral Summer Dress',
        productImageUrl: FakeData.products[8].mainImageUrl,
        productPrice: 9500,
        offerAmount: 5000,
        buyerId: user.id,
        buyerName: user.fullName,
        buyerAvatarUrl: user.avatarUrl,
        sellerId: 'u-010',
        sellerName: 'Chloé A.',
        status: OfferStatus.declined,
        direction: OfferDirection.sent,
        createdAt: now.subtract(const Duration(days: 4)),
        expiresAt: now.subtract(const Duration(days: 3)),
        respondedAt: now.subtract(const Duration(days: 3, hours: 6)),
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<Offer>>> getMyOffers() async {
    await _latency();
    _seed();
    final sorted = [..._offers]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Right(sorted);
  }

  @override
  Future<Either<Failure, Offer>> sendOffer({
    required String productId,
    required int amount,
    String? message,
  }) async {
    await _latency();
    _seed();
    final user = FakeData.currentUser;
    final product = FakeData.products.firstWhere(
      (p) => p.id == productId,
      orElse: () => FakeData.products.first,
    );
    final seller = FakeData.sellerFor(product.sellerId);
    final now = DateTime.now();
    final offer = Offer(
      id: 'of-${now.microsecondsSinceEpoch}',
      productId: product.id,
      productTitle: product.title,
      productImageUrl: product.mainImageUrl,
      productPrice: product.price,
      offerAmount: amount,
      buyerId: user.id,
      buyerName: user.fullName,
      buyerAvatarUrl: user.avatarUrl,
      sellerId: seller.id,
      sellerName: seller.fullName,
      sellerAvatarUrl: seller.avatarUrl,
      message: message,
      status: OfferStatus.pending,
      direction: OfferDirection.sent,
      createdAt: now,
      expiresAt: now.add(const Duration(hours: 24)),
    );
    _offers.insert(0, offer);
    return Right(offer);
  }

  @override
  Future<Either<Failure, Offer>> respond({
    required String offerId,
    required OfferStatus newStatus,
  }) async {
    await _latency();
    final idx = _offers.indexWhere((o) => o.id == offerId);
    if (idx < 0) {
      return const Left(ServerFailure(message: 'Offre introuvable'));
    }
    final updated =
        _offers[idx].copyWith(status: newStatus, respondedAt: DateTime.now());
    _offers[idx] = updated;
    return Right(updated);
  }

  @override
  Future<Either<Failure, void>> withdraw(String offerId) async {
    await _latency();
    final idx = _offers.indexWhere((o) => o.id == offerId);
    if (idx < 0) {
      return const Left(ServerFailure(message: 'Offre introuvable'));
    }
    _offers[idx] = _offers[idx].copyWith(status: OfferStatus.withdrawn);
    return const Right(null);
  }
}
