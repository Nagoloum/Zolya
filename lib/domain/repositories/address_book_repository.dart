import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/fake/ui_models.dart';

abstract class AddressBookRepository {
  Future<Either<Failure, List<AddressUi>>> getAddresses();
  Future<Either<Failure, AddressUi?>> getDefault();
  Future<Either<Failure, AddressUi>> addAddress({
    required String label,
    required String fullAddress,
    required bool isDefault,
  });
}
