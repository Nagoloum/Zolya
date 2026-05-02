import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel({
    required super.id,
    required super.orderId,
    required super.userId,
    required super.provider,
    super.providerTxId,
    super.phoneNumber,
    required super.amount,
    super.currency,
    required super.status,
    required super.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        orderId: json['order_id'] as String,
        userId: json['user_id'] as String,
        provider: _providerFromString(json['provider'] as String),
        providerTxId: json['provider_tx_id'] as String?,
        phoneNumber: json['phone_number'] as String?,
        amount: json['amount'] as int,
        currency: json['currency'] as String? ?? 'XAF',
        status: _statusFromString(json['status'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'user_id': userId,
        'provider': _providerToString(provider),
        'provider_tx_id': providerTxId,
        'phone_number': phoneNumber,
        'amount': amount,
        'currency': currency,
        'status': status.name,
      };

  static PaymentProvider _providerFromString(String s) => switch (s) {
        'orange_money' => PaymentProvider.orangeMoney,
        _ => PaymentProvider.mtnMomo,
      };

  static String _providerToString(PaymentProvider p) => switch (p) {
        PaymentProvider.mtnMomo => 'mtn_momo',
        PaymentProvider.orangeMoney => 'orange_money',
      };

  static PaymentStatus _statusFromString(String s) => switch (s) {
        'success' => PaymentStatus.success,
        'failed' => PaymentStatus.failed,
        'cancelled' => PaymentStatus.cancelled,
        _ => PaymentStatus.initiated,
      };
}
