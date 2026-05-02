import '../../domain/entities/wallet.dart';

class WalletModel extends Wallet {
  const WalletModel({
    required super.id,
    required super.userId,
    super.balance,
    super.pendingBalance,
    super.totalEarned,
    super.totalWithdrawn,
    required super.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        balance: json['balance'] as int? ?? 0,
        pendingBalance: json['pending_balance'] as int? ?? 0,
        totalEarned: json['total_earned'] as int? ?? 0,
        totalWithdrawn: json['total_withdrawn'] as int? ?? 0,
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}

class WalletTransactionModel extends WalletTransaction {
  const WalletTransactionModel({
    required super.id,
    required super.walletId,
    super.orderId,
    required super.type,
    required super.amount,
    required super.balanceAfter,
    super.description,
    required super.createdAt,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) => WalletTransactionModel(
        id: json['id'] as String,
        walletId: json['wallet_id'] as String,
        orderId: json['order_id'] as String?,
        type: _typeFromString(json['type'] as String),
        amount: json['amount'] as int,
        balanceAfter: json['balance_after'] as int,
        description: json['description'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  static WalletTxType _typeFromString(String s) => switch (s) {
        'credit_delivery' => WalletTxType.creditDelivery,
        'debit_withdraw' => WalletTxType.debitWithdraw,
        'commission' => WalletTxType.commission,
        'refund' => WalletTxType.refund,
        'adjustment' => WalletTxType.adjustment,
        _ => WalletTxType.creditSale,
      };
}
