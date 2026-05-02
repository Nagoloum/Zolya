import 'package:equatable/equatable.dart';

enum OfferStatus { pending, accepted, declined, expired, withdrawn }

enum OfferDirection { sent, received }

class Offer extends Equatable {
  final String id;
  final String productId;
  final String productTitle;
  final String? productImageUrl;
  final int productPrice;
  final int offerAmount;
  final String buyerId;
  final String buyerName;
  final String? buyerAvatarUrl;
  final String sellerId;
  final String sellerName;
  final String? sellerAvatarUrl;
  final String? message;
  final OfferStatus status;
  final OfferDirection direction;
  final DateTime createdAt;
  final DateTime expiresAt;
  final DateTime? respondedAt;

  const Offer({
    required this.id,
    required this.productId,
    required this.productTitle,
    this.productImageUrl,
    required this.productPrice,
    required this.offerAmount,
    required this.buyerId,
    required this.buyerName,
    this.buyerAvatarUrl,
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatarUrl,
    this.message,
    required this.status,
    required this.direction,
    required this.createdAt,
    required this.expiresAt,
    this.respondedAt,
  });

  bool get isPending => status == OfferStatus.pending;
  bool get isExpired =>
      status == OfferStatus.expired || DateTime.now().isAfter(expiresAt);

  int get discountPercent =>
      ((1 - offerAmount / productPrice) * 100).clamp(0, 99).round();

  Offer copyWith({
    OfferStatus? status,
    DateTime? respondedAt,
  }) {
    return Offer(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImageUrl: productImageUrl,
      productPrice: productPrice,
      offerAmount: offerAmount,
      buyerId: buyerId,
      buyerName: buyerName,
      buyerAvatarUrl: buyerAvatarUrl,
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatarUrl: sellerAvatarUrl,
      message: message,
      status: status ?? this.status,
      direction: direction,
      createdAt: createdAt,
      expiresAt: expiresAt,
      respondedAt: respondedAt ?? this.respondedAt,
    );
  }

  @override
  List<Object?> get props => [id, status, offerAmount, respondedAt];
}
