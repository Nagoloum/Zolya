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
