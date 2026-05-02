import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/payment.dart';

abstract class PaymentRepository {

  Future<Either<Failure, Payment>> initiatePayment({
    required String orderId,
    required PaymentProvider provider,
    required String phoneNumber,
    required int amount,
  });

  Future<Either<Failure, Payment>> checkPaymentStatus(String paymentId);

  Future<Either<Failure, Payment>> getPaymentByOrder(String orderId);
}
