import 'package:equatable/equatable.dart';

enum WalletTxType {
  creditSale,
  creditDelivery,
  debitWithdraw,
  commission,
  refund,
  adjustment,
}

class Wallet extends Equatable {
  final String id;
  final String userId;
  final int balance;
  final int pendingBalance;
  final int totalEarned;
  final int totalWithdrawn;
  final DateTime updatedAt;

  const Wallet({
    required this.id,
    required this.userId,
    this.balance = 0,
    this.pendingBalance = 0,
    this.totalEarned = 0,
    this.totalWithdrawn = 0,
    required this.updatedAt,
  });

  int get availableForWithdrawal => balance;

  @override
  List<Object?> get props => [id, userId, balance, pendingBalance];
}

class WalletTransaction extends Equatable {
  final String id;
  final String walletId;
  final String? orderId;
  final WalletTxType type;
  final int amount;
  final int balanceAfter;
  final String? description;
  final DateTime createdAt;

  const WalletTransaction({
    required this.id,
    required this.walletId,
    this.orderId,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    this.description,
    required this.createdAt,
  });

  bool get isCredit => amount > 0;

  @override
  List<Object?> get props => [id, walletId, type, amount, createdAt];
}
