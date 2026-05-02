class PaymentService {

  Future<String> initiatePayment({
    required String phone,
    required int amountFcfa,
    required String orderId,
    required MobileMoneyProvider provider,
  }) async {

    throw UnimplementedError('Payment integration pending');
  }

  Future<PaymentStatus> checkStatus(String transactionRef) async {
    throw UnimplementedError('Payment status check pending');
  }
}

enum MobileMoneyProvider { mtn, orange }

enum PaymentStatus { pending, success, failed, cancelled }
