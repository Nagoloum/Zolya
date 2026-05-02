import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/payment_methods_repository.dart';
import 'fake_data.dart';
import 'ui_models.dart';

class FakePaymentMethodsRepository implements PaymentMethodsRepository {
  final List<PaymentMethodUi> _methods = [...FakeData.paymentMethods];

  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<PaymentMethodUi>>> getMethods() async {
    await _latency();
    return Right(List.unmodifiable(_methods));
  }

  @override
  Future<Either<Failure, PaymentMethodUi?>> getDefault() async {
    await _latency();
    return Right(FakeData.defaultPaymentMethod ??
        (_methods.isNotEmpty ? _methods.first : null));
  }

  @override
  Future<Either<Failure, PaymentMethodUi>> addMethod({
    required MomoProvider provider,
    required String phone,
  }) async {
    await _latency();
    final created = PaymentMethodUi(
      id: 'p-${DateTime.now().millisecondsSinceEpoch}',
      provider: provider,
      maskedNumber: _mask(phone),
    );
    _methods.add(created);
    return Right(created);
  }

  String _mask(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 3) return '+237 ***';
    return '+237 ${digits.substring(0, 1)}** *** *${digits.substring(digits.length - 2)}';
  }
}
