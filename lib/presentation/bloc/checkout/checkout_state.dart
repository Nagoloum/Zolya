import 'package:equatable/equatable.dart';

import '../../../data/fake/ui_models.dart';

enum CheckoutPaymentKind { mtn, orange }

enum CheckoutStatus { idle, placing, success, failure }

class CheckoutState extends Equatable {
  const CheckoutState({
    required this.subtotal,
    this.vat = 0,
    this.shippingFee = 1000,
    this.address,
    this.method,
    this.payment = CheckoutPaymentKind.mtn,
    this.promoCode = '',
    this.status = CheckoutStatus.idle,
    this.errorMessage,
  });

  factory CheckoutState.initial(int subtotal) =>
      CheckoutState(subtotal: subtotal);

  final int subtotal;
  final int vat;
  final int shippingFee;
  final AddressUi? address;
  final PaymentMethodUi? method;
  final CheckoutPaymentKind payment;
  final String promoCode;
  final CheckoutStatus status;
  final String? errorMessage;

  int get total => subtotal + vat + shippingFee;

  bool get isPlacing => status == CheckoutStatus.placing;

  CheckoutState copyWith({
    int? subtotal,
    int? vat,
    int? shippingFee,
    AddressUi? address,
    PaymentMethodUi? method,
    CheckoutPaymentKind? payment,
    String? promoCode,
    CheckoutStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CheckoutState(
      subtotal: subtotal ?? this.subtotal,
      vat: vat ?? this.vat,
      shippingFee: shippingFee ?? this.shippingFee,
      address: address ?? this.address,
      method: method ?? this.method,
      payment: payment ?? this.payment,
      promoCode: promoCode ?? this.promoCode,
      status: status ?? this.status,
      errorMessage:
          clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        subtotal,
        vat,
        shippingFee,
        address,
        method,
        payment,
        promoCode,
        status,
        errorMessage,
      ];
}
