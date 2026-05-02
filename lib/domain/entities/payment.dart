import 'package:equatable/equatable.dart';

enum PaymentProvider { mtnMomo, orangeMoney }

enum PaymentStatus { initiated, success, failed, cancelled }

class Payment extends Equatable {
  final String id;
  final String orderId;
  final String userId;
  final PaymentProvider provider;
  final String? providerTxId;
  final String? phoneNumber;
  final int amount;
  final String currency;
  final PaymentStatus status;
  final DateTime createdAt;

  const Payment({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.provider,
    this.providerTxId,
    this.phoneNumber,
    required this.amount,
    this.currency = 'XAF',
    required this.status,
    required this.createdAt,
  });

  bool get isSuccess => status == PaymentStatus.success;

  @override
  List<Object?> get props => [id, orderId, provider, status, amount];
}

enum EscrowStatus { locked, released, refunded }

class EscrowTransaction extends Equatable {
  final String id;
  final String orderId;
  final int amountLocked;
  final EscrowStatus status;
  final DateTime lockedAt;
  final DateTime? releasedAt;
  final DateTime? refundedAt;

  const EscrowTransaction({
    required this.id,
    required this.orderId,
    required this.amountLocked,
    required this.status,
    required this.lockedAt,
    this.releasedAt,
    this.refundedAt,
  });

  @override
  List<Object?> get props => [id, orderId, status];
}

enum WithdrawalStatus { pending, processing, paid, rejected }

class Withdrawal extends Equatable {
  final String id;
  final String userId;
  final int amount;
  final PaymentProvider provider;
  final String phoneNumber;
  final WithdrawalStatus status;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime? processedAt;

  const Withdrawal({
    required this.id,
    required this.userId,
    required this.amount,
    required this.provider,
    required this.phoneNumber,
    this.status = WithdrawalStatus.pending,
    this.rejectionReason,
    required this.createdAt,
    this.processedAt,
  });

  @override
  List<Object?> get props => [id, userId, amount, status];
}
