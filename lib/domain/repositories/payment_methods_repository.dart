import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/fake/ui_models.dart';

abstract class PaymentMethodsRepository {
  Future<Either<Failure, List<PaymentMethodUi>>> getMethods();
  Future<Either<Failure, PaymentMethodUi?>> getDefault();
  Future<Either<Failure, PaymentMethodUi>> addMethod({
    required MomoProvider provider,
    required String phone,
  });
}
