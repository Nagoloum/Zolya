import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.phone,
    super.email,
    super.avatarUrl,
    super.role,
    super.isPhoneVerified,
    super.isCourier,
    super.isAdmin,
    super.isBanned,
    super.ratingAvg,
    super.ratingCount,
    super.walletBalance,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final isAdmin = json['is_admin'] as bool? ?? false;
    final isCourier = json['is_courier'] as bool? ?? false;
    return UserModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: _inferRole(isAdmin: isAdmin, isCourier: isCourier),
      isPhoneVerified: json['is_phone_verified'] as bool? ?? false,
      isCourier: isCourier,
      isAdmin: isAdmin,
      isBanned: json['is_banned'] as bool? ?? false,
      ratingAvg: (json['rating_avg'] as num?)?.toDouble() ?? 0,
      ratingCount: json['rating_count'] as int? ?? 0,
      walletBalance: json['wallet_balance'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'phone': phone,
        'email': email,
        'avatar_url': avatarUrl,
        'is_phone_verified': isPhoneVerified,
        'is_courier': isCourier,
        'is_admin': isAdmin,
        'is_banned': isBanned,
        'rating_avg': ratingAvg,
        'rating_count': ratingCount,
        'created_at': createdAt.toIso8601String(),
      };

  static UserRole _inferRole({required bool isAdmin, required bool isCourier}) {
    if (isAdmin) return UserRole.admin;
    if (isCourier) return UserRole.deliverer;
    return UserRole.buyer;
  }
}
