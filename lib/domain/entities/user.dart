import 'package:equatable/equatable.dart';

enum UserRole { buyer, seller, deliverer, admin }

class User extends Equatable {
  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final String? avatarUrl;
  final UserRole role;
  final bool isPhoneVerified;
  final bool isCourier;
  final bool isAdmin;
  final bool isBanned;
  final double ratingAvg;
  final int ratingCount;
  final int walletBalance;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    this.avatarUrl,
    this.role = UserRole.buyer,
    this.isPhoneVerified = false,
    this.isCourier = false,
    this.isAdmin = false,
    this.isBanned = false,
    this.ratingAvg = 0,
    this.ratingCount = 0,
    this.walletBalance = 0,
    required this.createdAt,
  });

  bool get canDeliver => isCourier && !isBanned;
  bool get isVerified => isPhoneVerified;

  User copyWith({
    String? fullName,
    String? email,
    String? avatarUrl,
    UserRole? role,
    bool? isPhoneVerified,
    bool? isCourier,
    bool? isAdmin,
    bool? isBanned,
    double? ratingAvg,
    int? ratingCount,
    int? walletBalance,
  }) {
    return User(
      id: id,
      fullName: fullName ?? this.fullName,
      phone: phone,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isCourier: isCourier ?? this.isCourier,
      isAdmin: isAdmin ?? this.isAdmin,
      isBanned: isBanned ?? this.isBanned,
      ratingAvg: ratingAvg ?? this.ratingAvg,
      ratingCount: ratingCount ?? this.ratingCount,
      walletBalance: walletBalance ?? this.walletBalance,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        phone,
        email,
        avatarUrl,
        role,
        isPhoneVerified,
        isCourier,
        isAdmin,
        isBanned,
        ratingAvg,
        ratingCount,
        walletBalance,
      ];
}
