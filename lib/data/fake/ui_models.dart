import 'package:flutter/material.dart';

class AddressUi {
  final String id;
  final String label;
  final String fullAddress;
  final bool isDefault;

  const AddressUi({
    required this.id,
    required this.label,
    required this.fullAddress,
    this.isDefault = false,
  });

  AddressUi copyWith({String? label, String? fullAddress, bool? isDefault}) {
    return AddressUi(
      id: id,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

enum MomoProvider { mtn, orange }

class PaymentMethodUi {
  final String id;
  final MomoProvider provider;
  final String maskedNumber;
  final bool isDefault;

  const PaymentMethodUi({
    required this.id,
    required this.provider,
    required this.maskedNumber,
    this.isDefault = false,
  });
}

class NotificationItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isNew;

  const NotificationItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isNew = false,
  });
}

class NotificationGroup {
  final String title;
  final List<NotificationItemData> items;

  const NotificationGroup({required this.title, required this.items});
}

class ReviewItemData {
  final int rating;
  final String comment;
  final String author;
  final String timeAgo;

  const ReviewItemData({
    required this.rating,
    required this.comment,
    required this.author,
    required this.timeAgo,
  });
}

class ProductRatingSummary {
  final double average;
  final int totalRatings;

  final List<int> breakdown;

  const ProductRatingSummary({
    required this.average,
    required this.totalRatings,
    required this.breakdown,
  });
}

class SellerProfileUi {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String? bio;
  final String city;
  final DateTime memberSince;
  final int totalSales;
  final int totalListings;
  final int followersCount;
  final int followingCount;
  final double averageRating;
  final int totalReviews;
  final List<int> ratingBreakdown;
  final List<String> languages;
  final bool isVerified;

  const SellerProfileUi({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.bio,
    required this.city,
    required this.memberSince,
    required this.totalSales,
    required this.totalListings,
    this.followersCount = 0,
    this.followingCount = 0,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingBreakdown,
    this.languages = const [],
    this.isVerified = false,
  });
}

class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

class FaqSection {
  final String title;
  final List<FaqItem> items;

  const FaqSection({required this.title, required this.items});
}

class DiscountUi {
  final String id;
  final String productId;
  final String productTitle;
  final String? productImageUrl;
  final int originalPrice;
  final int discountedPrice;
  final int discountPercent;
  final DateTime startedAt;
  final DateTime? endsAt;

  const DiscountUi({
    required this.id,
    required this.productId,
    required this.productTitle,
    this.productImageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.startedAt,
    this.endsAt,
  });
}
